/*
  Warnings:

  - You are about to drop the column `claimType` on the `Claim` table. All the data in the column will be lost.
  - Added the required column `type` to the `Claim` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Claim" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "claimDatetime" DATETIME NOT NULL,
    "nodeName" TEXT NOT NULL,
    "slot" INTEGER NOT NULL,
    "type" TEXT NOT NULL,
    CONSTRAINT "Claim_nodeName_fkey" FOREIGN KEY ("nodeName") REFERENCES "Node" ("name") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Claim" ("claimDatetime", "id", "nodeName", "slot") SELECT "claimDatetime", "id", "nodeName", "slot" FROM "Claim";
DROP TABLE "Claim";
ALTER TABLE "new_Claim" RENAME TO "Claim";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
