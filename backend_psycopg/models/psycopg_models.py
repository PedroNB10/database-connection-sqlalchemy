# Modelos adaptados para uso com psycopg (sem ORM)

from typing import Optional
import datetime
import decimal

class Categories:
    def __init__(self, categoryid: int, categoryname: Optional[str], description: Optional[str], rate: Optional[decimal.Decimal]):
        self.categoryid: int = categoryid
        self.categoryname: Optional[str] = categoryname
        self.description: Optional[str] = description
        self.rate: Optional[decimal.Decimal] = rate


class Customers:
    def __init__(self, customerid: str, companyname: Optional[str], contactname: Optional[str], contacttitle: Optional[str], address: Optional[str], city: Optional[str], region: Optional[str], postalcode: Optional[str], country: Optional[str], phone: Optional[str], fax: Optional[str]):
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
    def __init__(self, employeeid: int, lastname: Optional[str], firstname: Optional[str], title: Optional[str], titleofcourtesy: Optional[str], birthdate: Optional[datetime.datetime], hiredate: Optional[datetime.datetime], address: Optional[str], city: Optional[str], region: Optional[str], postalcode: Optional[str], country: Optional[str], homephone: Optional[str], extension: Optional[str], reportsto: Optional[int], notes: Optional[str]):
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
    def __init__(self, orderid: int, productid: int, unitprice: Optional[decimal.Decimal], quantity: Optional[int], discount: Optional[decimal.Decimal]):
        self.orderid: int = orderid
        self.productid: int = productid
        self.unitprice: Optional[decimal.Decimal] = unitprice
        self.quantity: Optional[int] = quantity
        self.discount: Optional[decimal.Decimal] = discount


class Shippers:
    def __init__(self, shipperid: int, companyname: Optional[str], phone: Optional[str]):
        self.shipperid: int = shipperid
        self.companyname: Optional[str] = companyname
        self.phone: Optional[str] = phone


class Suppliers:
    def __init__(self, supplierid: int, companyname: Optional[str], contactname: Optional[str], contacttitle: Optional[str], address: Optional[str], city: Optional[str], region: Optional[str], postalcode: Optional[str], country: Optional[str], phone: Optional[str], fax: Optional[str], homepage: Optional[str]):
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
    def __init__(self, orderid: int, customerid: str, employeeid: int, orderdate: Optional[datetime.datetime], requireddate: Optional[datetime.datetime], shippeddate: Optional[datetime.datetime], freight: Optional[decimal.Decimal], shipname: Optional[str], shipaddress: Optional[str], shipcity: Optional[str], shipregion: Optional[str], shippostalcode: Optional[str], shipcountry: Optional[str], shipperid: Optional[int]):
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
    def __init__(self, productid: int, supplierid: int, categoryid: int, productname: Optional[str], quantityperunit: Optional[str], unitprice: Optional[decimal.Decimal], unitsinstock: Optional[int], unitsonorder: Optional[int], reorderlevel: Optional[int], discontinued: Optional[str]):
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

