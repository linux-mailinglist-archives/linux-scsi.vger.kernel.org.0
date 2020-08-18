Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94136247C92
	for <lists+linux-scsi@lfdr.de>; Tue, 18 Aug 2020 05:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgHRDOw (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 17 Aug 2020 23:14:52 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:49142 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbgHRDOv (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 17 Aug 2020 23:14:51 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07I37fba032413;
        Tue, 18 Aug 2020 03:14:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=9YSiDMj9nir0xfrgRFBBt3TPa+WsRY9VPQ1CpN9Btew=;
 b=ifjF8h10MYEfrbE9tRIKrFrBhM62Y55YefvgUpdpU+aqNLD6/eGKwDNjQ5gZwznqga9B
 sS7YVroyWHy83PaPA/EzAgwslPrVqQw76DiPW09WHGdM892rhY4sRMNBl2Jlu+3qmMcI
 IJ4xGHhuKpdlLZFxb9XKbE3lVA76pmrKHuijSOqE430wUQnKYvtQsijC+wxpeYkFYT59
 CvsX0V2a+MsLmG9II4Looh3pOTShqzD9DFMhp+jhhyoZq1la4DQITglPgAW7+C1DRpWX
 Rgnd4r0kuc0jTGUC5gWvFGF8+3KpP9+yWywJsV8uldCCqvQLPALS6hRTSfIgLn5tz0x3 6Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 32x7nma5mf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 18 Aug 2020 03:14:46 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07I38Aon104586;
        Tue, 18 Aug 2020 03:12:45 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 32xsfraxsa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Aug 2020 03:12:45 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07I3CiCo020696;
        Tue, 18 Aug 2020 03:12:45 GMT
Received: from ca-mkp.ca.oracle.com (/10.156.108.201)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 17 Aug 2020 20:12:44 -0700
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     linux-scsi@vger.kernel.org, james.bottomley@hansenpartnership.com,
        Mike Christie <michael.christie@oracle.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] fcoe: fix io path allocation
Date:   Mon, 17 Aug 2020 23:12:29 -0400
Message-Id: <159772029325.19587.11765074400059811271.b4-ty@oracle.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <1596831813-9839-1-git-send-email-michael.christie@oracle.com>
References: <1596831813-9839-1-git-send-email-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9716 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=826
 spamscore=0 suspectscore=0 mlxscore=0 phishscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008180022
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9716 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 mlxscore=0 mlxlogscore=837
 lowpriorityscore=0 bulkscore=0 phishscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008180022
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Fri, 7 Aug 2020 15:23:33 -0500, Mike Christie wrote:

> ixgbe_fcoe_ddp_setup can be called from the main IO path and is called
> with a spin_lock held, so we have to use GFP_ATOMIC allocation instead
> of GFP_KERNEL.

Applied to 5.9/scsi-fixes, thanks!

[1/1] scsi: fcoe: Fix I/O path allocation
      https://git.kernel.org/mkp/scsi/c/fa39ab5184d6

-- 
Martin K. Petersen	Oracle Linux Engineering
