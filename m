Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D03F782E0
	for <lists+linux-scsi@lfdr.de>; Mon, 29 Jul 2019 02:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbfG2Aqh (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 28 Jul 2019 20:46:37 -0400
Received: from gateway30.websitewelcome.com ([192.185.148.2]:43830 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726247AbfG2Aqh (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Sun, 28 Jul 2019 20:46:37 -0400
X-Greylist: delayed 1227 seconds by postgrey-1.27 at vger.kernel.org; Sun, 28 Jul 2019 20:46:37 EDT
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id 9E30A3E5C
        for <linux-scsi@vger.kernel.org>; Sun, 28 Jul 2019 19:26:10 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id rtUQhyhrrYTGMrtUQhmsje; Sun, 28 Jul 2019 19:26:10 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=J6q2Z9mXVhAcXFg7BHgpSMzCnu+0qWjpsalOuE39dJQ=; b=ByAdEdsjp6/I4IQVvb7QE5ut+r
        p/+z/TpuPFHL6BO4zZuFRb3ZQHYCJGVf0Kp22Duc5Xw/yx1AIbwz+A4vh91RE/ce40hm0JdAUv24E
        64Dh2Ef3nVKuEBU5ewvlcjQ9p1NccLfGWqXNxSS5KEfPzJ7r329X+bN9624+t4lQFKsADary+uIEF
        smIKcTbHsWbmGNpqewOp9iQHE357UrAffFZ2Qj+LAhzFMi0fecFBwYp9Z1t9nur1VGrlRpDa68tk4
        P8c9k7aXnH5xoQEYzhOSGfRf14bDgaSWISGlNiD3874vlNVhsgU2fYmFwkflHF/BmwJGMhnKRzOG8
        B4mItewA==;
Received: from [187.192.11.120] (port=40060 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hrtUO-003y7d-RQ; Sun, 28 Jul 2019 19:26:09 -0500
Date:   Sun, 28 Jul 2019 19:26:08 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Tyrel Datwyler <tyreld@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] scsi: ibmvfc: Mark expected switch fall-throughs
Message-ID: <20190729002608.GA25263@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.192.11.120
X-Source-L: No
X-Exim-ID: 1hrtUO-003y7d-RQ
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [187.192.11.120]:40060
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 44
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Mark switch cases where we are expecting to fall through.

This patch fixes the following warnings:

drivers/scsi/ibmvscsi/ibmvfc.c: In function 'ibmvfc_npiv_login_done':
drivers/scsi/ibmvscsi/ibmvfc.c:4022:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
   ibmvfc_retry_host_init(vhost);
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/scsi/ibmvscsi/ibmvfc.c:4023:2: note: here
  case IBMVFC_MAD_DRIVER_FAILED:
  ^~~~
drivers/scsi/ibmvscsi/ibmvfc.c: In function 'ibmvfc_bsg_request':
drivers/scsi/ibmvscsi/ibmvfc.c:1830:11: warning: this statement may fall through [-Wimplicit-fallthrough=]
   port_id = (bsg_request->rqst_data.h_els.port_id[0] << 16) |
   ~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    (bsg_request->rqst_data.h_els.port_id[1] << 8) |
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    bsg_request->rqst_data.h_els.port_id[2];
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/scsi/ibmvscsi/ibmvfc.c:1833:2: note: here
  case FC_BSG_RPT_ELS:
  ^~~~
drivers/scsi/ibmvscsi/ibmvfc.c:1838:11: warning: this statement may fall through [-Wimplicit-fallthrough=]
   port_id = (bsg_request->rqst_data.h_ct.port_id[0] << 16) |
   ~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    (bsg_request->rqst_data.h_ct.port_id[1] << 8) |
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    bsg_request->rqst_data.h_ct.port_id[2];
    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/scsi/ibmvscsi/ibmvfc.c:1841:2: note: here
  case FC_BSG_RPT_CT:
  ^~~~

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/scsi/ibmvscsi/ibmvfc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc.c b/drivers/scsi/ibmvscsi/ibmvfc.c
index 8cdbac076a1b..df897df5cafe 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc.c
@@ -1830,6 +1830,7 @@ static int ibmvfc_bsg_request(struct bsg_job *job)
 		port_id = (bsg_request->rqst_data.h_els.port_id[0] << 16) |
 			(bsg_request->rqst_data.h_els.port_id[1] << 8) |
 			bsg_request->rqst_data.h_els.port_id[2];
+		/* fall through */
 	case FC_BSG_RPT_ELS:
 		fc_flags = IBMVFC_FC_ELS;
 		break;
@@ -1838,6 +1839,7 @@ static int ibmvfc_bsg_request(struct bsg_job *job)
 		port_id = (bsg_request->rqst_data.h_ct.port_id[0] << 16) |
 			(bsg_request->rqst_data.h_ct.port_id[1] << 8) |
 			bsg_request->rqst_data.h_ct.port_id[2];
+		/* fall through */
 	case FC_BSG_RPT_CT:
 		fc_flags = IBMVFC_FC_CT_IU;
 		break;
@@ -4020,6 +4022,7 @@ static void ibmvfc_npiv_login_done(struct ibmvfc_event *evt)
 		return;
 	case IBMVFC_MAD_CRQ_ERROR:
 		ibmvfc_retry_host_init(vhost);
+		/* fall through */
 	case IBMVFC_MAD_DRIVER_FAILED:
 		ibmvfc_free_event(evt);
 		return;
-- 
2.22.0

