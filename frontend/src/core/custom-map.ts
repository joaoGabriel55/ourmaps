export interface CustomMap {
  id: number;
  name: string;
  ownerId: string;
  description?: string;
  center: [number, number];
  // TODO: Avoid ANY PLEASE!
  content?: any;
  createdAt: Date;
  updatedAt?: Date;
}
