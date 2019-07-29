Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7733C79B0D
	for <lists+linux-scsi@lfdr.de>; Mon, 29 Jul 2019 23:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729873AbfG2V1h (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 29 Jul 2019 17:27:37 -0400
Received: from gateway32.websitewelcome.com ([192.185.145.187]:24894 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727093AbfG2V1h (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 29 Jul 2019 17:27:37 -0400
X-Greylist: delayed 1461 seconds by postgrey-1.27 at vger.kernel.org; Mon, 29 Jul 2019 17:27:37 EDT
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway32.websitewelcome.com (Postfix) with ESMTP id EC797204D2
        for <linux-scsi@vger.kernel.org>; Mon, 29 Jul 2019 16:03:15 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id sCnbhUTg6iQersCnbhtZJy; Mon, 29 Jul 2019 16:03:15 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=rYB1Oi2xBUPftVqsW5ammk/X8WPDKxniD3s8r/ZdzcM=; b=CeVA8+jrcwcsJ7eq5lJ5gEx6Rm
        NgaRix678if4vKht58ojdct83PV9/zRxP2jaPu1h6el1aQpmHCb5iDzEIXNjRIaQv1rZim+QB4jj3
        lYCQybOH7fMXkuWhEgNAI4DZKEyRVPAN25oPsqIVeNVtpWaJPGTnhrQg3Lr5XecpMUrRc/UlbSSRk
        yFzm+OXDCto/MKakRsqXHwxtwmHa3kaKiGxTr8uX7c+bDDuXMHEv5gJYUPcI59KlME8OV+NM6XdNF
        vv7+oCWJI6cHphi78Vbfc/AuuM0VhHGkjYfJsJYF/Yo18rQoxTlXig/FpVvEv4vVppFWT0WZbieEL
        0tbQLieA==;
Received: from [187.192.11.120] (port=59782 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hsCna-001QA0-H3; Mon, 29 Jul 2019 16:03:14 -0500
Date:   Mon, 29 Jul 2019 16:03:13 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH] scsi: wd33c93: Mark expected swich fall-through
Message-ID: <20190729210313.GA5896@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.192.11.120
X-Source-L: No
X-Exim-ID: 1hsCna-001QA0-H3
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [187.192.11.120]:59782
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Mark switch cases where we are expecting to fall through.

This patch fixes the following warning (Building: m68k):

drivers/scsi/wd33c93.c: In function ‘round_4’:
drivers/scsi/wd33c93.c:1856:11: warning: this statement may fall through [-Wimplicit-fallthrough=]
   case 2: ++x;
           ^~~
drivers/scsi/wd33c93.c:1857:3: note: here
   case 3: ++x;
   ^~~~

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/scsi/wd33c93.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/wd33c93.c b/drivers/scsi/wd33c93.c
index fb7b289fa09f..f81046f0e68a 100644
--- a/drivers/scsi/wd33c93.c
+++ b/drivers/scsi/wd33c93.c
@@ -1854,6 +1854,7 @@ round_4(unsigned int x)
 		case 1: --x;
 			break;
 		case 2: ++x;
+			/* fall through */
 		case 3: ++x;
 	}
 	return x;
-- 
2.22.0

