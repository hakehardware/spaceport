import { z } from 'zod';

export const createSchema = z.object({
    nodeName: z.string(),
    type: z.string(),
    data: z.string(),
    eventDatetime: z.string().datetime()
})