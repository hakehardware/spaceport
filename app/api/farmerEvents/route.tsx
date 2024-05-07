import { NextRequest, NextResponse } from "next/server";
import prisma from "@/prisma/client";
import { createSchema } from "./schema";
import { Prisma } from "@prisma/client";

export async function GET(request: NextRequest) {
  const events = await prisma.farmerEvent.findMany();
  return NextResponse.json(events);
}

export async function POST(request: NextRequest) {
  try {
    const body = await request.json();
    const validation = createSchema.safeParse(body);

    if (!validation.success)
      return NextResponse.json(validation.error.errors, { status: 400 });

    const farmerEvent = await prisma.farmerEvent.findFirst({
      where: {
        eventDatetime: body.eventDatetime,
        farmerName: body.farmerName,
        type: body.type,
        data: body.data,
      },
    });

    if (farmerEvent)
      return NextResponse.json({ message: "Farmer Event already exists" }, {status: 200});

    const newFarmerEvent = await prisma.farmerEvent.create({
      data: {
        eventDatetime: body.eventDatetime,
        farmerName: body.farmerName,
        type: body.type,
        data: body.data,
      },
    });

    return NextResponse.json(newFarmerEvent, { status: 201 });

  } catch (e) {
    if (e instanceof Prisma.PrismaClientKnownRequestError) {
        return NextResponse.json({'error': e.message}, { status: 400 });
    }
  }
}