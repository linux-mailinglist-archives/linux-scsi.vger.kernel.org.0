Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 522101DAC64
	for <lists+linux-scsi@lfdr.de>; Wed, 20 May 2020 09:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgETHj5 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 20 May 2020 03:39:57 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:35990 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbgETHj5 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 20 May 2020 03:39:57 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id CDC20299D4;
        Wed, 20 May 2020 03:39:53 -0400 (EDT)
Date:   Wed, 20 May 2020 17:39:55 +1000 (AEST)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Daniel Wagner <dwagner@suse.de>
cc:     Bart Van Assche <bvanassche@acm.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "James E. J. Bottomley" <jejb@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        Arun Easi <aeasi@marvell.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        Nilesh Javali <njavali@marvell.com>,
        Quinn Tran <qutran@marvell.com>,
        Martin Wilck <mwilck@suse.com>,
        Roman Bolshakov <r.bolshakov@yadro.com>
Subject: Re: [PATCH v7 15/15] qla2xxx: Fix endianness annotations in source
 files
In-Reply-To: <20200519152401.oh6cewdru3fu7ogd@beryllium.lan>
Message-ID: <alpine.LNX.2.22.394.2005201726250.8@nippy.intranet>
References: <20200518211712.11395-1-bvanassche@acm.org> <20200518211712.11395-16-bvanassche@acm.org> <20200519152401.oh6cewdru3fu7ogd@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi Daniel,

On Tue, 19 May 2020, Daniel Wagner wrote:

> 
> I tried to figure out if with the patch the compiler generates different 
> object code. Looking through the filtered diff between the two versions 
> I haven't really found any relevant changes. All looks good.
> 
> In case someone wants to look at the diffs:
> 
> https://monom.org/data/qla2xxx/qla2xxx-endianness-annotations.diff 
> https://monom.org/data/qla2xxx/qla2xxx-endianness-annotations-filtered.diff
> 

I agree. qla2xxx-endianness-annotations.diff seems to be noise.

The differences in the __bug_table sections and ql_dbg() call sites are 
presumably caused by line break changes. Perhaps they can be squelched by 
inserting blank lines at the appropriate places (for either build). That 
could probably be automated.

Once the comments are stripped from the .s files, we are left with 
differences like this,

@@ -21204,75 +21205,75 @@
        .quad   .LC146
        .quad   .LC146
        .quad   .LC272
+       .local  __key.63281
+       .comm   __key.63281,0,1
        .local  __key.63280
        .comm   __key.63280,0,1
-       .local  __key.63279
-       .comm   __key.63279,0,1
        .align 16
-       .type   __func__.63244, @object
-       .size   __func__.63244, 22
-__func__.63244:
+       .type   __func__.63245, @object
+       .size   __func__.63245, 22
+__func__.63245:
        .string "qlt_24xx_config_rings"
        .align 16
        .type   __func__.61306, @object
        .size   __func__.61306, 26

...

@@ -2571,7 +2571,7 @@
        .pushsection __jump_table,  "aw" 
         .balign 8 
        .long 1b - ., .L218 - .         #
-        .quad __UNIQUE_ID_ddebug285.63134+40 + 0 - .   #,
+        .quad __UNIQUE_ID_ddebug285.63135+40 + 0 - .   #,
        .popsection 
        
 # 0 "" 2

It would be nice to know how these symbols end up with different numbering 
between builds because it makes a real mess of the diff.

I wonder whether the Reproducible Builds project has developed any 
techniques that could be applied here.
https://reproducible-builds.org/
