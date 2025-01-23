export const signUp = async (email: string, password: string) => {
  return {
    id: "61682ddc-08da-4eef-921c-65db6143ff36",
    name: "John Doe",
    email,
    createdAt: new Date().toISOString(),
    updatedAt: new Date().toISOString(),
  };
};
