
  CREATE TABLE "CARS_SOURCE" 
   (	"ID" NUMBER NOT NULL ENABLE, 
	"CAR_ID" VARCHAR2(50), 
	"MILEAGE" NUMBER, 
	"VEHICLE_AGE" NUMBER, 
	"REPORTED_ISSUES" NUMBER, 
	"TIRE_CONDITION" NUMBER, 
	"BRAKE_CONDITION" NUMBER, 
	"BATTERY_STATUS" NUMBER, 
	"DAY_SINCE_LAST_SERVICE" DATE, 
	"DAY_TO_WARRANTY_EXPIRE" DATE
   ) ;