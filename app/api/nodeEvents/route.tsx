import { NextRequest, NextResponse } from "next/server";
import prisma from "@/prisma/client";
import { createSchema } from "./schema";
import { Prisma } from "@prisma/client";

export async function GET(request: NextRequest) {
  const events = await prisma.nodeEvent.findMany();
  return NextResponse.json(events);
}

export async function POST(request: NextRequest) {
  try {
    const body = await request.json();
    const validation = createSchema.safeParse(body);

    if (!validation.success)
      return NextResponse.json(validation.error.errors, { status: 400 });

    const nodeEvent = await prisma.nodeEvent.findFirst({
      where: {
        eventDatetime: body.eventDatetime,
        nodeName: body.nodeName,
        type: body.nodeName,
        data: body.data,
      },
    });

    if (nodeEvent)
      return NextResponse.json({ message: "Node Event already exists" });

    const newNodeEvent = await prisma.nodeEvent.create({
      data: {
        eventDatetime: body.eventDatetime,
        nodeName: body.nodeName,
        type: body.nodeName,
        data: body.data,
      },
    });

    return NextResponse.json(newNodeEvent, { status: 201 });

  } catch (e) {
    if (e instanceof Prisma.PrismaClientKnownRequestError) {
        return NextResponse.json({'error': e.message}, { status: 400 });
    }
  }
}
