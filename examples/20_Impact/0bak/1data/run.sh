#!/bin/bash
atomsk --create bcc 3.18 Cu final.unitecell.cfg
atomsk --polycrystal final.unitecell.cfg polycrystal.txt final.lmp -wrap
