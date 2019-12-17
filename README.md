# Salesforce Apex Rest Framework

## Webservice Versioning

version-namespace is used so the url contains a version number.

```
/services/apexrest/notify/v1/*
```

The purpose of each version is to guarantee the same behaviour across version number

## Request 

* **Http Verb** : POST
* **Headers** 
    * Authorization : Bearer <access_token>
* **URI**
    * The name of the service. ex : /services/apexrest/notify/v1/example
* **Body**
    * The content of the call. (structure depends on the Resource reached)

## Response

* **Status Code** : 
    * 202 accepted
    * 500 Internal Server Error
* **Body** : contains two attributs : *data* and *error. *Both are array of objects. When error is set, data is null. When data is set, error is null
    * data : contains an array of object. Service called design the Structure of the object in the array
    * errors : contains an array of error (code and message). Code is functional code and message is the related message
* **Exception Handling** : error attribut is set and Status Code is 500 

## Authentication

You need to provide in the header of the call an access token available at least on the API scope
The solution supports these [authentication](https://developer.salesforce.com/docs/atlas.en-us.222.0.api_rest.meta/api_rest/quickstart_oauth.htm) mechanisms:

* OAuth 2.0
* Session ID

## HTTP Call

### Request

**handler_class_name** : the name of the class to call
**instance_url** : the salesforce url
**access_token** : the session
**body_content** : the content of the POST

```
POST /services/apexrest/router/v1/<handler_class_name> HTTP/1.1
Host: <instance_url>
Authorization: Bearer <access_token>
Content-Type: application/json
Accept: *\/*
Host: <instance_url>
Accept-Encoding: gzip, deflate

<body_content>
```

### Response

**Content-Type** : application.json
```
{
    "errors": [],
    "data": []
}
```

## Retry

Reexecute the call.
It is the responsibility of the service called to guarantee idempotence

## How to implement new Endpoint ?

Create a class (and the related test class) extending rest_RestHandler.
Use the attribut req to get the request content and do the treatment you need
Use the attribut res to modify the response following 
Add result in the responseContent attribut of the class using
this.responseContent.data.add(<your structure>);
the rest_ApexRouter.RouterRestResponse structure

Add error in the responseContent attribut of the class using :
this.responseContent.errors.add(new rest_ApexRouter.RouterRestError(<code>,<message>))
