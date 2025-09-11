module Todos
  class UpdateTool < MCP::Tool
    tool_name "todo-update-tool"
    description "Update a Todo entity of a given ID"

    input_schema(
      properties: {
        id: { type: "integer" },
        title: { type: "string" },
        description: { type: "string" },
        completed: { type: "boolean" }
      },
      required: [ "id" ]
    )

    def self.call(id:, title: MCP::EmptyProperty, description: MCP::EmptyProperty, completed: MCP::EmptyProperty, server_context:)
      todo = Todo.find(id)

      todo.title = title unless title == MCP::EmptyProperty
      todo.description = description unless description == MCP::EmptyProperty
      todo.completed = completed unless completed == MCP::EmptyProperty

      if todo.save
        MCP::Tool::Response.new([ { type: "text", text: "Updated #{todo.to_mcp_response}" } ])
      else
        MCP::Tool::Response.new([ { type: "text", text: "Todo of id = #{id} was not updated due to the following errors: #{todo.errors.full_messages.join(', ')}" } ])
      end
    rescue ActiveRecord::RecordNotFound
      MCP::Tool::Response.new([ { type: "text", text: "Todo of id = #{id} was not found" } ])
    rescue StandardError => e
      MCP::Tool::Response.new([ { type: "text", text: "An error occurred, what happened was #{e.message}" } ])
    end
  end
end
