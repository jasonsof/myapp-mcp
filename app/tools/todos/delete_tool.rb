module Todos
  class DeleteTool < MCP::Tool
    tool_name "todo-delete-tool"
    description "Delete a Todo entity of the given ID"

    input_schema(
      properties: {
        id: { type: "integer" }
      },
      required: [ "id" ]
    )

    def self.call(id:, server_context:)
      todo = Todo.find(id)
      todo.destroy!

      MCP::Tool::Response.new([ { type: "text", text: "Todo of id = #{id} was deleted" } ])
    rescue ActiveRecord::RecordNotFound
      MCP::Tool::Response.new([ { type: "text", text: "Todo of id = #{id} was not found" } ])
    rescue StandardError => e
      MCP::Tool::Response.new([ { type: "text", text: "An error occurred, what happened was #{e.message}" } ])
    end
  end
end
