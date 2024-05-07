/*
  Warnings:

  - You are about to drop the column `nodeId` on the `Consensus` table. All the data in the column will be lost.
  - The primary key for the `Farmer` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `id` on the `Farmer` table. All the data in the column will be lost.
  - You are about to drop the column `nodeId` on the `Farmer` table. All the data in the column will be lost.
  - You are about to drop the column `farmerId` on the `FarmerError` table. All the data in the column will be lost.
  - You are about to drop the column `farmerId` on the `FarmerEvent` table. All the data in the column will be lost.
  - The primary key for the `Node` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `id` on the `Node` table. All the data in the column will be lost.
  - The primary key for the `Farm` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `farmerId` on the `Farm` table. All the data in the column will be lost.
  - You are about to drop the column `nodeId` on the `NodeError` table. All the data in the column will be lost.
  - You are about to drop the column `nodeId` on the `NodeEvent` table. All the data in the column will be lost.
  - You are about to drop the column `nodeId` on the `Claim` table. All the data in the column will be lost.
  - Added the required column `nodeName` to the `Consensus` table without a default value. This is not possible if the table is not empty.
  - Added the required column `nodeName` to the `Farmer` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updatedAt` to the `Farmer` table without a default value. This is not possible if the table is not empty.
  - Added the required column `farmerName` to the `FarmerError` table without a default value. This is not possible if the table is not empty.
  - Added the required column `farmerName` to the `FarmerEvent` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updatedAt` to the `Node` table without a default value. This is not possible if the table is not empty.
  - Added the required column `farmerName` to the `Farm` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updatedAt` to the `Farm` table without a default value. This is not possible if the table is not empty.
  - Added the required column `nodeName` to the `NodeError` table without a default value. This is not possible if the table is not empty.
  - Added the required column `nodeName` to the `NodeEvent` table without a default value. This is not possible if the table is not empty.
  - Added the required column `nodeName` to the `Claim` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Consensus" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "consensusDatetime" DATETIME NOT NULL,
    "nodeName" TEXT NOT NULL,
    CONSTRAINT "Consensus_nodeName_fkey" FOREIGN KEY ("nodeName") REFERENCES "Node" ("name") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Consensus" ("consensusDatetime", "id") SELECT "consensusDatetime", "id" FROM "Consensus";
DROP TABLE "Consensus";
ALTER TABLE "new_Consensus" RENAME TO "Consensus";
CREATE TABLE "new_Farmer" (
    "name" TEXT NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    "active" BOOLEAN NOT NULL,
    "workers" INTEGER,
    "pieceCachePct" REAL,
    "farmIp" TEXT,
    "nodeName" TEXT NOT NULL,
    CONSTRAINT "Farmer_nodeName_fkey" FOREIGN KEY ("nodeName") REFERENCES "Node" ("name") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Farmer" ("active", "createdAt", "farmIp", "name", "pieceCachePct", "workers") SELECT "active", "createdAt", "farmIp", "name", "pieceCachePct", "workers" FROM "Farmer";
DROP TABLE "Farmer";
ALTER TABLE "new_Farmer" RENAME TO "Farmer";
CREATE UNIQUE INDEX "Farmer_name_key" ON "Farmer"("name");
CREATE TABLE "new_FarmerError" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "errorDatetime" DATETIME NOT NULL,
    "farmerName" TEXT NOT NULL,
    "message" TEXT NOT NULL,
    CONSTRAINT "FarmerError_farmerName_fkey" FOREIGN KEY ("farmerName") REFERENCES "Farmer" ("name") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_FarmerError" ("errorDatetime", "id", "message") SELECT "errorDatetime", "id", "message" FROM "FarmerError";
DROP TABLE "FarmerError";
ALTER TABLE "new_FarmerError" RENAME TO "FarmerError";
CREATE TABLE "new_FarmerEvent" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "eventDatetime" DATETIME NOT NULL,
    "farmerName" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "data" TEXT NOT NULL,
    CONSTRAINT "FarmerEvent_farmerName_fkey" FOREIGN KEY ("farmerName") REFERENCES "Farmer" ("name") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_FarmerEvent" ("data", "eventDatetime", "id", "type") SELECT "data", "eventDatetime", "id", "type" FROM "FarmerEvent";
DROP TABLE "FarmerEvent";
ALTER TABLE "new_FarmerEvent" RENAME TO "FarmerEvent";
CREATE TABLE "new_Node" (
    "name" TEXT NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'Initializing',
    "active" BOOLEAN NOT NULL,
    "ip" TEXT
);
INSERT INTO "new_Node" ("active", "createdAt", "ip", "name", "status") SELECT "active", "createdAt", "ip", "name", "status" FROM "Node";
DROP TABLE "Node";
ALTER TABLE "new_Node" RENAME TO "Node";
CREATE UNIQUE INDEX "Node_name_key" ON "Node"("name");
CREATE TABLE "new_Farm" (
    "id" TEXT NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    "farmerName" TEXT NOT NULL,
    "index" INTEGER NOT NULL,
    "publicKey" TEXT,
    "allocatedSpace" REAL,
    "directory" TEXT,
    "status" TEXT,
    CONSTRAINT "Farm_farmerName_fkey" FOREIGN KEY ("farmerName") REFERENCES "Farmer" ("name") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Farm" ("allocatedSpace", "createdAt", "directory", "id", "index", "publicKey", "status") SELECT "allocatedSpace", "createdAt", "directory", "id", "index", "publicKey", "status" FROM "Farm";
DROP TABLE "Farm";
ALTER TABLE "new_Farm" RENAME TO "Farm";
CREATE UNIQUE INDEX "Farm_id_key" ON "Farm"("id");
CREATE TABLE "new_Plot" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "plotDatetime" DATETIME NOT NULL,
    "farmId" TEXT NOT NULL,
    "percentComplete" REAL NOT NULL,
    "currentSector" INTEGER NOT NULL,
    "type" TEXT NOT NULL,
    CONSTRAINT "Plot_farmId_fkey" FOREIGN KEY ("farmId") REFERENCES "Farm" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Plot" ("currentSector", "farmId", "id", "percentComplete", "plotDatetime", "type") SELECT "currentSector", "farmId", "id", "percentComplete", "plotDatetime", "type" FROM "Plot";
DROP TABLE "Plot";
ALTER TABLE "new_Plot" RENAME TO "Plot";
CREATE TABLE "new_NodeError" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "errorDatetime" DATETIME NOT NULL,
    "nodeName" TEXT NOT NULL,
    "message" TEXT NOT NULL,
    CONSTRAINT "NodeError_nodeName_fkey" FOREIGN KEY ("nodeName") REFERENCES "Node" ("name") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_NodeError" ("errorDatetime", "id", "message") SELECT "errorDatetime", "id", "message" FROM "NodeError";
DROP TABLE "NodeError";
ALTER TABLE "new_NodeError" RENAME TO "NodeError";
CREATE TABLE "new_NodeEvent" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "eventDatetime" DATETIME NOT NULL,
    "nodeName" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "data" TEXT NOT NULL,
    CONSTRAINT "NodeEvent_nodeName_fkey" FOREIGN KEY ("nodeName") REFERENCES "Node" ("name") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_NodeEvent" ("data", "eventDatetime", "id", "type") SELECT "data", "eventDatetime", "id", "type" FROM "NodeEvent";
DROP TABLE "NodeEvent";
ALTER TABLE "new_NodeEvent" RENAME TO "NodeEvent";
CREATE TABLE "new_Claim" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "claimDatetime" DATETIME NOT NULL,
    "nodeName" TEXT NOT NULL,
    CONSTRAINT "Claim_nodeName_fkey" FOREIGN KEY ("nodeName") REFERENCES "Node" ("name") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Claim" ("claimDatetime", "id") SELECT "claimDatetime", "id" FROM "Claim";
DROP TABLE "Claim";
ALTER TABLE "new_Claim" RENAME TO "Claim";
CREATE TABLE "new_Reward" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "rewardDatetime" DATETIME NOT NULL,
    "farmId" TEXT NOT NULL,
    "hash" TEXT NOT NULL,
    "success" BOOLEAN NOT NULL,
    CONSTRAINT "Reward_farmId_fkey" FOREIGN KEY ("farmId") REFERENCES "Farm" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Reward" ("farmId", "hash", "id", "rewardDatetime", "success") SELECT "farmId", "hash", "id", "rewardDatetime", "success" FROM "Reward";
DROP TABLE "Reward";
ALTER TABLE "new_Reward" RENAME TO "Reward";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
