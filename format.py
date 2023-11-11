import os
import textwrap

def process_file(filepath, max_length=80):
    with open(filepath, 'r', encoding='utf-8') as file:
        lines = file.read().split('\n')

    wrapped_lines = []
    wrapper = textwrap.TextWrapper(width=max_length, break_long_words=False, break_on_hyphens=False)
    for line in lines:
        if line.strip().startswith('%'):
            # if the line is a comment, just add it to the output as is
            wrapped_lines.append(line)
        elif '%' in line:
            # if the line contains a comment, split it into the comment and the code
            code, comment = line.split('%', 1)
            # wrap the code and comment separately
            wrapped_code = wrapper.wrap(code)
            wrapped_comment = wrapper.wrap('%' + comment)
            # add the wrapped lines to the output
            wrapped_lines.extend(wrapped_code + wrapped_comment)
        elif len(line) > max_length:
            # if the line is not a comment and is too long, wrap it
            wrapped_lines.extend(wrapper.wrap(line))
        else:
            # otherwise, just add the line to the output as is
            wrapped_lines.append(line)

    with open(filepath, 'w', encoding='utf-8') as file:
        file.write('\n'.join(wrapped_lines))

def process_directory(directory, max_length=80):
    for filename in os.listdir(directory):
        if filename.endswith('.tex'):
            process_file(os.path.join(directory, filename), max_length)


def main():
    for el in ['cmp', 'dp', 'piaps', 'ssrd', 'vp']:
        process_directory(f'./chapters-{el}', 80)


if __name__ == "__main__":
    main()