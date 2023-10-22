-- Create Table
CREATE TABLE SubscriptionKinds (
    subscriptionMode CHAR(1),
    subscriptionInterval VARCHAR(60),
    rate numeric(7,2),
    stillOffered BOOLEAN,
    PRIMARY KEY (subscriptionMode, subscriptionInterval),
    FOREIGN KEY (subscriptionMode, subscriptionInterval) REFERENCES SubscriptionKinds (subscriptionMode,subscriptionInterval)
);

CREATE TABLE Editions(
    editionDate DATE,
    numArticles INT,
    numPages INT,
    PRIMARY KEY (editionDate)
);

CREATE TABLE Subscribers(
    subscriberPhone INT,
    subscriberName VARCHAR(50),
    subscriberAddress VARCHAR(60),
    PRIMARY KEY (subscriberPhone)
);

CREATE TABLE Subscriptions(
    subscriberPhone INT,
    subscriptionStartDate DATE,
    subscriptionMode CHAR(1),
    subscriptionInterval VARCHAR(255),
    paymentReceived BOOLEAN,
    PRIMARY KEY (subscriberPhone, subscriptionStartDate),
    FOREIGN KEY (subscriberPhone) REFERENCES Subscribers (subscriberPhone),
    FOREIGN KEY (subscriptionMode, subscriptionInterval) REFERENCES SubscriptionKinds (subscriptionMode,subscriptionInterval)
);

CREATE TABLE Holds(
    subscriberPhone INT,
    subscriptionStartDate DATE,
    holdStartDate DATE,
    holdEndDate DATE,
    PRIMARY KEY (subscriberPhone, subscriptionStartDate, holdStartDate),
    FOREIGN KEY (subscriberPhone, subscriptionStartDate) REFERENCES Subscriptions (subscriberPhone, subscriptionStartDate)
);

CREATE TABLE Articles(
    editionDate DATE,
    articleNum INT,
    articleAuthor VARCHAR(50),
    articlePage INT,
    PRIMARY KEY (editionDate, articleNum),
    FOREIGN KEY (editionDate) REFERENCES Editions (editionDate)
);

CREATE TABLE ReadArticles(
    subscriberPhone INT,
    editionDate DATE,
    articleNum INT,
    readInterval TIME,
    PRIMARY KEY (subscriberPhone, editionDate, articleNum),
    FOREIGN KEY (subscriberPhone) REFERENCES Subscribers (subscriberPhone),
    FOREIGN KEY (editionDate, articleNum) REFERENCES Articles(editionDate, articleNum)
);
