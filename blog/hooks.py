import os
import shutil

def copy_fonts(config, **kwargs):
    site_dir = config['site_dir']
    shutil.copytree('blog/static/fonts', os.path.join(site_dir, 'get'))
