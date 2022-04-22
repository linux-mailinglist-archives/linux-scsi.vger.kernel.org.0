Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4746950B2BD
	for <lists+linux-scsi@lfdr.de>; Fri, 22 Apr 2022 10:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444729AbiDVIXb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-scsi@lfdr.de>); Fri, 22 Apr 2022 04:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444756AbiDVIX1 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 22 Apr 2022 04:23:27 -0400
Received: from mx4.uni-regensburg.de (mx4.uni-regensburg.de [IPv6:2001:638:a05:137:165:0:4:4e7a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216AF48318
        for <linux-scsi@vger.kernel.org>; Fri, 22 Apr 2022 01:20:34 -0700 (PDT)
Received: from mx4.uni-regensburg.de (localhost [127.0.0.1])
        by localhost (Postfix) with SMTP id 4ABF3600004E;
        Fri, 22 Apr 2022 10:20:31 +0200 (CEST)
Received: from gwsmtp.uni-regensburg.de (gwsmtp1.uni-regensburg.de [132.199.5.51])
        by mx4.uni-regensburg.de (Postfix) with ESMTP id 343C56000050;
        Fri, 22 Apr 2022 10:20:31 +0200 (CEST)
Received: from uni-regensburg-smtp1-MTA by gwsmtp.uni-regensburg.de
        with Novell_GroupWise; Fri, 22 Apr 2022 10:20:31 +0200
Message-Id: <6262654D020000A100049812@gwsmtp.uni-regensburg.de>
X-Mailer: Novell GroupWise Internet Agent 18.4.0 
Date:   Fri, 22 Apr 2022 10:20:29 +0200
From:   "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
To:     <michael.christie@oracle.com>, "Lee Duncan" <lduncan@suse.com>
Cc:     "open-iscsi" <open-iscsi@googlegroups.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, "Chris Leech" <cleech@redhat.com>,
        <kernel-janitors@vger.kernel.org>, <linux-scsi@vger.kernel.org>
Subject: Antw: [EXT] [PATCH] scsi: iscsi: fix harmless double shift bug
References: <YmFyWHf8nrrx+SHa@kili>
In-Reply-To: <YmFyWHf8nrrx+SHa@kili>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

>>> Dan Carpenter <dan.carpenter@oracle.com> schrieb am 21.04.2022 um 17:03 in
Nachricht <YmFyWHf8nrrx+SHa@kili>:
> These flags are supposed to be bit numbers.  Right now they cause a
> double shift bug where we use BIT(BIT(2)) instead of BIT(2).
> Fortunately, the bit numbers are small and it's done consistently so it
> does not cause an issue at run time.
> 
> Fixes: 5bd856256f8c ("scsi: iscsi: Merge suspend fields")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  include/scsi/libiscsi.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/scsi/libiscsi.h b/include/scsi/libiscsi.h
> index d0a24779c52d..c0703cd20a99 100644
> --- a/include/scsi/libiscsi.h
> +++ b/include/scsi/libiscsi.h
> @@ -54,9 +54,9 @@ enum {
>  #define ISID_SIZE			6
>  
>  /* Connection flags */
> -#define ISCSI_CONN_FLAG_SUSPEND_TX	BIT(0)
> -#define ISCSI_CONN_FLAG_SUSPEND_RX	BIT(1)
> -#define ISCSI_CONN_FLAG_BOUND		BIT(2)
> +#define ISCSI_CONN_FLAG_SUSPEND_TX	0
> +#define ISCSI_CONN_FLAG_SUSPEND_RX	1
> +#define ISCSI_CONN_FLAG_BOUND		2

Actually it's not the "flag" then, but the "flag's bit position".
Personally I think applying BIT() again is the bug, not the definition.

>  
>  #define ISCSI_ITT_MASK			0x1fff
>  #define ISCSI_TOTAL_CMDS_MAX		4096
> -- 
> 2.20.1
> 
> -- 
> You received this message because you are subscribed to the Google Groups 
> "open-iscsi" group.
> To unsubscribe from this group and stop receiving emails from it, send an 
> email to open-iscsi+unsubscribe@googlegroups.com.
> To view this discussion on the web visit 
> https://groups.google.com/d/msgid/open-iscsi/YmFyWHf8nrrx%2BSHa%40kili.




