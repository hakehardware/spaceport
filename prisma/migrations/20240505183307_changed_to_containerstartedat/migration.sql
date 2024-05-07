/*
  Warnings:

  - You are about to drop the column `containerStarted` on the `Node` table. All the data in the column will be lost.
  - Added the required column `containerStartedAt` to the `Node` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Node" (
    "name" TEXT NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'Initializing',
    "active" BOOLEAN NOT NULL,
    "hostIp" TEXT NOT NULL,
    "containerStatus" TEXT NOT NULL,
    "version" TEXT NOT NULL,
    "containerStartedAt" DATETIME NOT NULL
);
INSERT INTO "new_Node" ("active", "containerStatus", "createdAt", "hostIp", "name", "status", "updatedAt", "version") SELECT "active", "containerStatus", "createdAt", "hostIp", "name", "status", "updatedAt", "version" FROM "Node";
DROP TABLE "Node";
ALTER TABLE "new_Node" RENAME TO "Node";
CREATE UNIQUE INDEX "Node_name_key" ON "Node"("name");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
