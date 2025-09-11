module Todos
  class ShowTool < MCP::Tool
    tool_name "todo-show-tool"
    description "Show all information about Todo of the given ID"

    input_schema(
      properties: {
        id: { type: "integer" }
      },
      required: [ "id" ]
    )

    def self.call(id:, server_context:)
      todo = Todo.find(id)

      MCP::Tool::Response.new([ { type: "text", text: todo.to_mcp_response } ])
    rescue ActiveRecord::RecordNotFound
      MCP::Tool::Response.new([ { type: "text", text: "Todo of id = #{id} was not found" } ])
    rescue StandardError => e
      MCP::Tool::Response.new([ { type: "text", text: "An error occurred, what happened was #{e.message}" } ])
    end
  end
end
