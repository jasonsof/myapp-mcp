module Todos
  class CreateTool < MCP::Tool
    tool_name "todo-create-tool"
    description "Create a new Todo entity"

    input_schema(
      properties: {
        title: { type: "string" },
        description: { type: "string" },
        completed: { type: "boolean" }
      },
      required: []
    )

    def self.call(title: nil, description: nil, completed: nil, server_context:)
      todo = Todo.new(
        title: title,
description: description,
completed: completed
      )

      if todo.save
        MCP::Tool::Response.new([ { type: "text", text: "Created #{todo.to_mcp_response}" } ])
      else
        MCP::Tool::Response.new([ { type: "text", text: "Todo was not created due to the following errors: #{todo.errors.full_messages.join(', ')}" } ])
      end
    rescue StandardError => e
      MCP::Tool::Response.new([ { type: "text", text: "An error occurred, what happened was #{e.message}" } ])
    end
  end
end
