// Vertex Shader
// ?? Places the verts in an isosoles triangle shape according to the index?

struct VertexOutput {
    @builtin(position) clip_position: vec4<f32>, // TODO: remind yourself exactly what clip space is
    @location(0) color:vec3<f32> // TODO: are we overwriting the vert buffer ??
};



@vertex
fn vert_main(
    @builtin(vertex_index) curr_vert_index:u32, // we can use these because they are buffers defined and written to in the configuration of the vert buffers
    @location(0) position:vec3<f32>, 
    @location(1) color:vec3<f32>
) -> VertexOutput {
    var return_data:VertexOutput;
    let x = f32(1 - i32(curr_vert_index)) * 0.5;
    let y = f32(i32(curr_vert_index & 1u) * 2 - 1) * 0.5; // ?? wtf is & 1u ??
    return_data.clip_position = vec4<f32>(x, y, 0.0, 1.0);
    return_data.color = color;
    return return_data;
}

@group(0) @binding(0) var<uniform> cursor_pos: vec4<f32>;

// In combo with the vert shader, creates triangle of arbitrary returned
@fragment
fn frag_main(vert_data: VertexOutput) -> @location(0) vec4<f32> {
    // return this arbitrary color,
    var dist = length(vec4<f32>(vert_data.color[0], vert_data.color[1], 0.0, 0.0) - cursor_pos);
    if dist < 0.2 {
        return vec4<f32>(1.0, 0.0, 0.0, 1.0);
    } else {
        return vec4<f32>(vert_data.color, 1.0);
    }
}