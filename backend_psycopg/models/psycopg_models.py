# Modelos adaptados para uso com psycopg (sem ORM)

from typing import Optional
import datetime
import decimal

class Categories:
    def __init__(self, categoryid: int = None, categoryname: Optional[str] = None, description: Optional[str] = None, rate: Optional[decimal.Decimal] = None):
        self.categoryid: int = categoryid
        self.categoryname: Optional[str] = categoryname
        self.description: Optional[str] = description
        self.rate: Optional[decimal.Decimal] = rate


class Customers:
    def __init__(self, customerid: str = None, companyname: Optional[str] = None, contactname: Optional[str] = None, contacttitle: Optional[str] = None, address: Optional[str] = None, city: Optional[str] = None, region: Optional[str] = None, postalcode: Optional[str] = None, country: Optional[str] = None, phone: Optional[str] = None, fax: Optional[str] = None):
        self.customerid: str = customerid
        self.companyname: Optional[str] = companyname
        self.contactname: Optional[str] = contactname
        self.contacttitle: Optional[str] = contacttitle
        self.address: Optional[str] = address
        self.city: Optional[str] = city
        self.region: Optional[str] = region
        self.postalcode: Optional[str] = postalcode
        self.country: Optional[str] = country
        self.phone: Optional[str] = phone
        self.fax: Optional[str] = fax


class Employees:
    def __init__(self, employeeid: int = None, lastname: Optional[str] = None, firstname: Optional[str] = None, title: Optional[str] = None, titleofcourtesy: Optional[str] = None, birthdate: Optional[datetime.datetime] = None, hiredate: Optional[datetime.datetime] = None, address: Optional[str] = None, city: Optional[str] = None, region: Optional[str] = None, postalcode: Optional[str] = None, country: Optional[str] = None, homephone: Optional[str] = None, extension: Optional[str] = None, reportsto: Optional[int] = None, notes: Optional[str] = None):
        self.employeeid: int = employeeid
        self.lastname: Optional[str] = lastname
        self.firstname: Optional[str] = firstname
        self.title: Optional[str] = title
        self.titleofcourtesy: Optional[str] = titleofcourtesy
        self.birthdate: Optional[datetime.datetime] = birthdate
        self.hiredate: Optional[datetime.datetime] = hiredate
        self.address: Optional[str] = address
        self.city: Optional[str] = city
        self.region: Optional[str] = region
        self.postalcode: Optional[str] = postalcode
        self.country: Optional[str] = country
        self.homephone: Optional[str] = homephone
        self.extension: Optional[str] = extension
        self.reportsto: Optional[int] = reportsto
        self.notes: Optional[str] = notes


class OrderDetails:
    def __init__(self, orderid: int = None, productid: int = None, unitprice: Optional[decimal.Decimal] = None, quantity: Optional[int] = None, discount: Optional[decimal.Decimal] = None):
        self.orderid: int = orderid
        self.productid: int = productid
        self.unitprice: Optional[decimal.Decimal] = unitprice
        self.quantity: Optional[int] = quantity
        self.discount: Optional[decimal.Decimal] = discount


class Shippers:
    def __init__(self, shipperid: int = None, companyname: Optional[str] = None, phone: Optional[str] = None):
        self.shipperid: int = shipperid
        self.companyname: Optional[str] = companyname
        self.phone: Optional[str] = phone


class Suppliers:
    def __init__(self, supplierid: int = None, companyname: Optional[str] = None, contactname: Optional[str] = None, contacttitle: Optional[str] = None, address: Optional[str] = None, city: Optional[str] = None, region: Optional[str] = None, postalcode: Optional[str] = None, country: Optional[str] = None, phone: Optional[str] = None, fax: Optional[str] = None, homepage: Optional[str] = None):
        self.supplierid: int = supplierid
        self.companyname: Optional[str] = companyname
        self.contactname: Optional[str] = contactname
        self.contacttitle: Optional[str] = contacttitle
        self.address: Optional[str] = address
        self.city: Optional[str] = city
        self.region: Optional[str] = region
        self.postalcode: Optional[str] = postalcode
        self.country: Optional[str] = country
        self.phone: Optional[str] = phone
        self.fax: Optional[str] = fax
        self.homepage: Optional[str] = homepage


class Orders:
    def __init__(self, orderid: int = None, customerid: str = None, employeeid: int = None, orderdate: Optional[datetime.datetime] = None, requireddate: Optional[datetime.datetime] = None, shippeddate: Optional[datetime.datetime] = None, freight: Optional[decimal.Decimal] = None, shipname: Optional[str] = None, shipaddress: Optional[str] = None, shipcity: Optional[str] = None, shipregion: Optional[str] = None, shippostalcode: Optional[str] = None, shipcountry: Optional[str] = None, shipperid: Optional[int] = None):
        self.orderid: int = orderid
        self.customerid: str = customerid
        self.employeeid: int = employeeid
        self.orderdate: Optional[datetime.datetime] = orderdate
        self.requireddate: Optional[datetime.datetime] = requireddate
        self.shippeddate: Optional[datetime.datetime] = shippeddate
        self.freight: Optional[decimal.Decimal] = freight
        self.shipname: Optional[str] = shipname
        self.shipaddress: Optional[str] = shipaddress
        self.shipcity: Optional[str] = shipcity
        self.shipregion: Optional[str] = shipregion
        self.shippostalcode: Optional[str] = shippostalcode
        self.shipcountry: Optional[str] = shipcountry
        self.shipperid: Optional[int] = shipperid


class Products:
    def __init__(self, productid: int = None, supplierid: int = None, categoryid: int = None, productname: Optional[str] = None, quantityperunit: Optional[str] = None, unitprice: Optional[decimal.Decimal] = None, unitsinstock: Optional[int] = None, unitsonorder: Optional[int] = None, reorderlevel: Optional[int] = None, discontinued: Optional[str] = None):
        self.productid: int = productid
        self.supplierid: int = supplierid
        self.categoryid: int = categoryid
        self.productname: Optional[str] = productname
        self.quantityperunit: Optional[str] = quantityperunit
        self.unitprice: Optional[decimal.Decimal] = unitprice
        self.unitsinstock: Optional[int] = unitsinstock
        self.unitsonorder: Optional[int] = unitsonorder
        self.reorderlevel: Optional[int] = reorderlevel
        self.discontinued: Optional[str] = discontinued

