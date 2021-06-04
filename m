Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A081639B073
	for <lists+linux-scsi@lfdr.de>; Fri,  4 Jun 2021 04:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbhFDCgG (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 3 Jun 2021 22:36:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:46630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229576AbhFDCgG (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 3 Jun 2021 22:36:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1575F6140A;
        Fri,  4 Jun 2021 02:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622774060;
        bh=CTwdnVeRv3LZ9cDRRph64ebpUyTxPlHR4nhm8m1iUqA=;
        h=Date:From:To:Cc:Subject:From;
        b=HCGLVAT+lX0dKye5fFNli0CkXdx9hzeI1f4tlBjtHoho7HjPQIWzBvAl+XpxT/NV6
         0htrQmOXw1godBVqUOVSa1Mn+9XfzETf/YCR1rvlFKzuuGcLmisvJ9O5s/uOK6n1Mg
         8m0THhk+UJ9KKRbKhpeS/mU/wnFRH1LxRPW7UB9ql7DcLv4Dz+xbsbrv4I7Jtv19oS
         BNX4456Xrr4l8l1B0oA7CHJeItxdFnvdYk2am7yotFjPnbSR3zWjngRx+IfnFi/GCk
         KfyvutlUfKw/Sop+1cFqcDDmc5X9atwQlFa3+6+1SbPl0z2YtAOn/ITd+gcspj3Blw
         mCNbTmG4zorNg==
Date:   Thu, 3 Jun 2021 21:35:30 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: [PATCH][next] scsi: mpi3mr: Fix fall-through warning for Clang
Message-ID: <20210604023530.GA180997@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

In preparation to enable -Wimplicit-fallthrough for Clang, fix a
fall-through warning by explicitly adding a break statement instead
of just letting the code fall through to the next case.

Link: https://github.com/KSPP/linux/issues/115
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
JFYI: We had thousands of these sorts of warnings and now we are down
      to just 22 in linux-next. This is one of those last remaining
      warnings.

 drivers/scsi/mpi3mr/mpi3mr_os.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/mpi3mr/mpi3mr_os.c b/drivers/scsi/mpi3mr/mpi3mr_os.c
index a54aa009ec5a..4ab0609a1b94 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_os.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_os.c
@@ -1732,6 +1732,7 @@ static void mpi3mr_sastopochg_evt_th(struct mpi3mr_ioc *mrioc,
 				atomic_dec_if_positive
 				    (&scsi_tgt_priv_data->block_io);
 			}
+			break;
 		case MPI3_EVENT_SAS_TOPO_PHY_RC_PHY_CHANGED:
 		default:
 			break;
-- 
2.27.0

