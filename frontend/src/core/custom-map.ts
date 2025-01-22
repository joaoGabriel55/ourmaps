export interface CustomMap {
  id: number;
  name: string;
  ownerId: string;
  description?: string;
  center: [number, number];
  visibility: "public" | "private";
  // TODO: Avoid ANY PLEASE!
  content?: any;
  createdAt: Date;
  updatedAt?: Date;
}
