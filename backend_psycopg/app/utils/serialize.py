def serialize(obj):
    # You can exclude keys starting with "_" to filter out internal attributes
    return {k: v for k, v in obj.__dict__.items() if not k.startswith("_")}
