Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5D2C2BB403
	for <lists+linux-scsi@lfdr.de>; Fri, 20 Nov 2020 19:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731435AbgKTSjW (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 20 Nov 2020 13:39:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:57758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729041AbgKTSjV (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 20 Nov 2020 13:39:21 -0500
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A49D21D91;
        Fri, 20 Nov 2020 18:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605897560;
        bh=RqqgcxMvaSOfAkQahvw6xsxnznyPix8tRQtQTvAF1uE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TH+QoL/vAqmhndav8BJK/kvQ7hviiARBKO4uuPyu7jcNXnDYKRvjR/9Poz/lhULU1
         selFUbtZ1foyWpvgMVDt5V+rYp/xlkqA6r8blXF/HaZmnce5m3sNn4+T0mwXn5Hqra
         XHWbHfHGNrO2ZYHRY2xOlYEClYh3YDGw3CqTjY+s=
Date:   Fri, 20 Nov 2020 12:39:26 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 122/141] scsi: csiostor: Fix fall-through warnings for Clang
Message-ID: <b77ee091548f16b52056c3b9ee8c76dc6691f868.1605896060.git.gustavoars@kernel.org>
References: <cover.1605896059.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1605896059.git.gustavoars@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
by explicitly adding a break statement instead of letting the code fall
through to the next case.

Link: https://github.com/KSPP/linux/issues/115
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/scsi/csiostor/csio_wr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/csiostor/csio_wr.c b/drivers/scsi/csiostor/csio_wr.c
index 9010cb6045dc..fe0355c964bc 100644
--- a/drivers/scsi/csiostor/csio_wr.c
+++ b/drivers/scsi/csiostor/csio_wr.c
@@ -830,6 +830,7 @@ csio_wr_destroy_queues(struct csio_hw *hw, bool cmd)
 				if (flq_idx != -1)
 					csio_q_flid(hw, flq_idx) = CSIO_MAX_QID;
 			}
+			break;
 		default:
 			break;
 		}
-- 
2.27.0

