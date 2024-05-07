import { z } from 'zod';

export const createSchema = z.object({
    farmerName: z.string(),
    type: z.string(),
    data: z.string(),
    eventDatetime: z.string().datetime()
})