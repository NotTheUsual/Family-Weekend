require_relative 'spec_helper'

describe NewsPost do
  it 'can render its body as HTML' do
    post = NewsPost.new(body: '# Header')
    expect(post.body_as_html).to eq(
      '<h1>Header</h1>
') # Can't get newline character to work. This works.
  end

  it 'can format its timestamp as a date' do
    post = NewsPost.new(created_at: Time.new(2014, 4, 5));
    expect(post.date).to eq('April 5, 2014')
  end
end