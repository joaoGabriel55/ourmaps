<script>
  import AppLogo from "$lib/components/AppLogo.svelte";
</script>

<div class="h-screen bg-gradient-to-r from-primary to-accent">
  <div class="flex flex-col gap-8 justify-center items-center h-full">
    <AppLogo />
    <h2 class="card-title font-medium text-3xl text-white">
      You tried to view a map that you don't have access to.
    </h2>
  </div>
</div>
