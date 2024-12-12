export const getPrivateMaps = async () => {
  return [
    {
      id: 1,
      name: "My Map 1",
      description: "My map description",
      owner: { id: 1, name: "John Doe" },
      createdAt: new Date(),
      updatedAt: new Date(),
    },
    {
      id: 2,
      name: "My Map 2",
      description: "My map description",
      owner: { id: 1, name: "John Doe" },
      createdAt: new Date(),
      updatedAt: new Date(),
    },
    {
      id: 3,
      name: "My Map 3",
      description: "My map description",
      owner: { id: 1, name: "John Doe" },
      createdAt: new Date(),
      updatedAt: new Date(),
    },
  ];
};

export const getPublicMaps = async () => {
  return [
    { id: 1, name: "Shared Map 1", description: "Shared map description" },
    { id: 2, name: "Shared Map 2", description: "Shared map description" },
    { id: 3, name: "Shared Map 3", description: "Shared map description" },
  ];
};
