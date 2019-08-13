Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 979918B896
	for <lists+linux-scsi@lfdr.de>; Tue, 13 Aug 2019 14:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbfHMMbc (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 13 Aug 2019 08:31:32 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:64249
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726903AbfHMMbc (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 13 Aug 2019 08:31:32 -0400
X-IronPort-AV: E=Sophos;i="5.64,381,1559512800"; 
   d="scan'208";a="316282409"
Received: from portablejulia.rsr.lip6.fr ([132.227.76.63])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Aug 2019 14:31:18 +0200
Date:   Tue, 13 Aug 2019 14:31:18 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: julia@hadrien
To:     Matthias Maennich <maennich@google.com>
cc:     linux-kernel@vger.kernel.org, maco@android.com,
        kernel-team@android.com, arnd@arndb.de, geert@linux-m68k.org,
        gregkh@linuxfoundation.org, hpa@zytor.com, jeyu@kernel.org,
        joel@joelfernandes.org, kstewart@linuxfoundation.org,
        linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-m68k@vger.kernel.org, linux-modules@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-usb@vger.kernel.org,
        lucas.de.marchi@gmail.com, maco@google.com,
        michal.lkml@markovi.net, mingo@redhat.com, oneukum@suse.com,
        pombredanne@nexb.com, sam@ravnborg.org, sboyd@codeaurora.org,
        sspatil@google.com, stern@rowland.harvard.edu, tglx@linutronix.de,
        usb-storage@lists.one-eyed-alien.net, x86@kernel.org,
        yamada.masahiro@socionext.com, Julia Lawall <Julia.Lawall@lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        cocci@systeme.lip6.fr
Subject: Re: [PATCH v2 08/10] scripts: Coccinelle script for namespace
 dependencies.
In-Reply-To: <20190813121733.52480-9-maennich@google.com>
Message-ID: <alpine.DEB.2.21.1908131430530.4608@hadrien>
References: <20180716122125.175792-1-maco@android.com> <20190813121733.52480-1-maennich@google.com> <20190813121733.52480-9-maennich@google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org



On Tue, 13 Aug 2019, Matthias Maennich wrote:

> A script that uses the '<module>.ns_deps' file generated by modpost to
> automatically add the required symbol namespace dependencies to each
> module.
>
> Usage:
> 1) Move some symbols to a namespace with EXPORT_SYMBOL_NS() or define
>    DEFAULT_SYMBOL_NAMESPACE
> 2) Run 'make' (or 'make modules') and get warnings about modules not
>    importing that namespace.
> 3) Run 'make nsdeps' to automatically add required import statements
>    to said modules.
>
> This makes it easer for subsystem maintainers to introduce and maintain
> symbol namespaces into their codebase.
>
> Co-developed-by: Martijn Coenen <maco@android.com>
> Signed-off-by: Martijn Coenen <maco@android.com>
> Signed-off-by: Matthias Maennich <maennich@google.com>

Acked-by: Julia Lawall <julia.lawall@lip6.fr>


> ---
>  MAINTAINERS                                 |  5 ++
>  Makefile                                    | 12 +++++
>  scripts/Makefile.modpost                    |  4 +-
>  scripts/coccinelle/misc/add_namespace.cocci | 23 +++++++++
>  scripts/nsdeps                              | 54 +++++++++++++++++++++
>  5 files changed, 97 insertions(+), 1 deletion(-)
>  create mode 100644 scripts/coccinelle/misc/add_namespace.cocci
>  create mode 100644 scripts/nsdeps
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e81e60bd7c26..aa169070a052 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11414,6 +11414,11 @@ S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/wtarreau/nolibc.git
>  F:	tools/include/nolibc/
>
> +NSDEPS
> +M:	Matthias Maennich <maennich@google.com>
> +S:	Maintained
> +F:	scripts/nsdeps
> +
>  NTB AMD DRIVER
>  M:	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
>  L:	linux-ntb@googlegroups.com
> diff --git a/Makefile b/Makefile
> index 1b23f95db176..c5c3356e133c 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1500,6 +1500,9 @@ help:
>  	@echo  '  headerdep       - Detect inclusion cycles in headers'
>  	@echo  '  coccicheck      - Check with Coccinelle'
>  	@echo  ''
> +	@echo  'Tools:'
> +	@echo  '  nsdeps          - Generate missing symbol namespace dependencies'
> +	@echo  ''
>  	@echo  'Kernel selftest:'
>  	@echo  '  kselftest       - Build and run kernel selftest (run as root)'
>  	@echo  '                    Build, install, and boot kernel before'
> @@ -1687,6 +1690,15 @@ quiet_cmd_tags = GEN     $@
>  tags TAGS cscope gtags: FORCE
>  	$(call cmd,tags)
>
> +# Script to generate missing namespace dependencies
> +# ---------------------------------------------------------------------------
> +
> +PHONY += nsdeps
> +
> +nsdeps:
> +	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modpost nsdeps
> +	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/$@
> +
>  # Scripts to check various things for consistency
>  # ---------------------------------------------------------------------------
>
> diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
> index 26e6574ecd08..743fe3a2e885 100644
> --- a/scripts/Makefile.modpost
> +++ b/scripts/Makefile.modpost
> @@ -56,7 +56,8 @@ MODPOST = scripts/mod/modpost						\
>  	$(if $(KBUILD_EXTMOD),$(addprefix -e ,$(KBUILD_EXTRA_SYMBOLS)))	\
>  	$(if $(KBUILD_EXTMOD),-o $(modulesymfile))			\
>  	$(if $(CONFIG_SECTION_MISMATCH_WARN_ONLY),,-E)			\
> -	$(if $(KBUILD_MODPOST_WARN),-w)
> +	$(if $(KBUILD_MODPOST_WARN),-w)					\
> +	$(if $(filter nsdeps,$(MAKECMDGOALS)),-d)
>
>  ifdef MODPOST_VMLINUX
>
> @@ -134,6 +135,7 @@ $(modules): %.ko :%.o %.mod.o FORCE
>
>  targets += $(modules)
>
> +nsdeps: __modpost
>
>  # Add FORCE to the prequisites of a target to force it to be always rebuilt.
>  # ---------------------------------------------------------------------------
> diff --git a/scripts/coccinelle/misc/add_namespace.cocci b/scripts/coccinelle/misc/add_namespace.cocci
> new file mode 100644
> index 000000000000..c832bb6445a8
> --- /dev/null
> +++ b/scripts/coccinelle/misc/add_namespace.cocci
> @@ -0,0 +1,23 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +//
> +/// Adds missing MODULE_IMPORT_NS statements to source files
> +///
> +/// This script is usually called from scripts/nsdeps with -D ns=<namespace> to
> +/// add a missing namespace tag to a module source file.
> +///
> +
> +@has_ns_import@
> +declarer name MODULE_IMPORT_NS;
> +identifier virtual.ns;
> +@@
> +MODULE_IMPORT_NS(ns);
> +
> +// Add missing imports, but only adjacent to a MODULE_LICENSE statement.
> +// That ensures we are adding it only to the main module source file.
> +@do_import depends on !has_ns_import@
> +declarer name MODULE_LICENSE;
> +expression license;
> +identifier virtual.ns;
> +@@
> +MODULE_LICENSE(license);
> ++ MODULE_IMPORT_NS(ns);
> diff --git a/scripts/nsdeps b/scripts/nsdeps
> new file mode 100644
> index 000000000000..148db65a830f
> --- /dev/null
> +++ b/scripts/nsdeps
> @@ -0,0 +1,54 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Linux kernel symbol namespace import generator
> +#
> +# This script requires at least spatch
> +# version 1.0.4.
> +SPATCH_REQ_VERSION="1.0.4"
> +
> +DIR="$(dirname $(readlink -f $0))/.."
> +SPATCH="`which ${SPATCH:=spatch}`"
> +if [ ! -x "$SPATCH" ]; then
> +    echo 'spatch is part of the Coccinelle project and is available at http://coccinelle.lip6.fr/'
> +    exit 1
> +fi
> +
> +SPATCH_REQ_VERSION_NUM=$(echo $SPATCH_REQ_VERSION | ${DIR}/scripts/ld-version.sh)
> +SPATCH_VERSION=$($SPATCH --version | head -1 | awk '{print $3}')
> +SPATCH_VERSION_NUM=$(echo $SPATCH_VERSION | ${DIR}/scripts/ld-version.sh)
> +
> +if [ "$SPATCH_VERSION_NUM" -lt "$SPATCH_REQ_VERSION_NUM" ] ; then
> +    echo 'spatch needs to be version 1.06 or higher'
> +    exit 1
> +fi
> +
> +generate_deps_for_ns() {
> +    $SPATCH --very-quiet --in-place --sp-file \
> +	    $srctree/scripts/coccinelle/misc/add_namespace.cocci -D ns=$1 $2
> +}
> +
> +generate_deps() {
> +    local mod_file=`echo $@ | sed -e 's/\.ns_deps/\.mod/'`
> +    local mod_name=`cat $mod_file | sed -n 1p | sed -e 's/\/[^.]*$//'`
> +    local mod_source_files=`cat $mod_file | sed -n 2p | sed -e 's/\.o/\.c/g'`
> +    for ns in `cat $@`; do
> +	echo "Adding namespace $ns to module $mod_name (if needed)."
> +        generate_deps_for_ns $ns $mod_source_files
> +	# sort the imports
> +        for source_file in $mod_source_files; do
> +            sed '/MODULE_IMPORT_NS/Q' $source_file > ${source_file}.tmp
> +            offset=$(wc -l ${source_file}.tmp | awk '{print $1;}')
> +            cat $source_file | grep MODULE_IMPORT_NS | sort -u >> ${source_file}.tmp
> +            tail -n +$((offset +1)) ${source_file} | grep -v MODULE_IMPORT_NS >> ${source_file}.tmp
> +            if ! diff -q ${source_file} ${source_file}.tmp; then
> +                mv ${source_file}.tmp ${source_file}
> +            else
> +                rm ${source_file}.tmp
> +            fi
> +        done
> +    done
> +}
> +
> +for f in `find $srctree/.tmp_versions/ -name *.ns_deps`; do
> +    generate_deps $f
> +done
> --
> 2.23.0.rc1.153.gdeed80330f-goog
>
>
