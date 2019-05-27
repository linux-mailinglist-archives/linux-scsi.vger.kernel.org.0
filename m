Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7221E2B154
	for <lists+linux-scsi@lfdr.de>; Mon, 27 May 2019 11:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbfE0JbU (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 27 May 2019 05:31:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:42208 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725991AbfE0JbU (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 27 May 2019 05:31:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5DF4DADE5;
        Mon, 27 May 2019 09:31:19 +0000 (UTC)
Date:   Mon, 27 May 2019 11:31:18 +0200
From:   David Disseldorp <ddiss@suse.de>
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
Subject: Re: [PATCH] target/iscsi: fix possible condition with no effect (if
 == else)
Message-ID: <20190527113118.68e6ab4c@suse.de>
In-Reply-To: <20190525174416.GA21510@hari-Inspiron-1545>
References: <20190525174416.GA21510@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Sat, 25 May 2019 23:14:16 +0530, Hariprasad Kelam wrote:

> fix below warning reported by coccicheck
> 
> drivers/target/iscsi/iscsi_target_nego.c:175:6-8: WARNING: possible
> condition with no effect (if == else)
> 
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
> ---
>  drivers/target/iscsi/iscsi_target_nego.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/target/iscsi/iscsi_target_nego.c b/drivers/target/iscsi/iscsi_target_nego.c
> index 8a5e8d1..b6fb70a 100644
> --- a/drivers/target/iscsi/iscsi_target_nego.c
> +++ b/drivers/target/iscsi/iscsi_target_nego.c
> @@ -168,12 +168,7 @@ static u32 iscsi_handle_authentication(
>  	else if (strstr("CHAP", authtype))
>  		return chap_main_loop(conn, auth, in_buf, out_buf,
>  				&in_length, out_length);
> -	else if (strstr("SPKM1", authtype))
> -		return 2;
> -	else if (strstr("SPKM2", authtype))
> -		return 2;
> -	else if (strstr("KRB5", authtype))
> -		return 2;
> +	/* ret 2 in  SPKM1,SPKM2,KRB5 cases */
>  	else
>  		return 2;
>  }

Looks okay, though I'd prefer to drop the unnecessary "else" too. The
CANSRP hunk can also be removed here. I.e. something like:

--- a/drivers/target/iscsi/iscsi_target_nego.c
+++ b/drivers/target/iscsi/iscsi_target_nego.c
@@ -160,22 +160,11 @@ static u32 iscsi_handle_authentication(
 
        if (strstr("None", authtype))
                return 1;
-#ifdef CANSRP
-       else if (strstr("SRP", authtype))
-               return srp_main_loop(conn, auth, in_buf, out_buf,
-                               &in_length, out_length);
-#endif
        else if (strstr("CHAP", authtype))
                return chap_main_loop(conn, auth, in_buf, out_buf,
                                &in_length, out_length);
-       else if (strstr("SPKM1", authtype))
-               return 2;
-       else if (strstr("SPKM2", authtype))
-               return 2;
-       else if (strstr("KRB5", authtype))
-               return 2;
-       else
-               return 2;
+       /* SRP, SPKM1, SPKM2 and KRB5 are unsupported */
+       return 2;
 }

Cheers, David
