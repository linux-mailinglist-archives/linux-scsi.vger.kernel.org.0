Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C71A11DA802
	for <lists+linux-scsi@lfdr.de>; Wed, 20 May 2020 04:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbgETCa0 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 19 May 2020 22:30:26 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:57986 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726938AbgETCa0 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 19 May 2020 22:30:26 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04K2RBMa084676;
        Wed, 20 May 2020 02:30:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=hMtYUQ5YmbU6uxtCjgQbZkOgQHRj66GMfK4dk2UsHUk=;
 b=fp69WNmBwoIif02W+4sYKi4vZ6uI4FdZ1WP4yw5M/vtpYa5uRAp3UF8AdnAZzchgFRuq
 58z5V5yihsqnhryKBNnUAhchJszTZ2oHiung5wOM+CSD2hbTw+KwYKJeI/Uqc9rvESuh
 zqVIuv9QP4X9GxFXA4JTuWSrG0PXaeQBT6GSTaw98RX/4AVJ/Lh+7Mf/3/G6mjDB3MhD
 +5r0xdVqWwEpgu0X/ogYKgMa1054DsugMj2RO/YXy8zuf+Lb+5YMMNkrPUva6ez2WkzM
 /aRBDQnqF6JZD/b5/poVB2M90jIcKkPJrdZf87f/eVxwnW80Mvelx5w5PEsSSz3k+ld8 GQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 3127kr8n99-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 20 May 2020 02:30:15 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04K2SQPE001362;
        Wed, 20 May 2020 02:30:15 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 314gm65d21-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 May 2020 02:30:15 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04K2UDQh027914;
        Wed, 20 May 2020 02:30:13 GMT
Received: from ca-mkp.ca.oracle.com (/10.156.108.201)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 19 May 2020 19:30:13 -0700
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Can Guo <cang@codeaurora.org>, linux-scsi@vger.kernel.org,
        Avri Altman <avri.altman@wdc.com>,
        Bean Huo <beanhuo@micron.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Asutosh Das <asutoshd@codeaurora.org>
Subject: Re: [PATCH RFC] ufs: Make ufshcd_wait_for_register() sleep instead of busy-waiting
Date:   Tue, 19 May 2020 22:30:02 -0400
Message-Id: <158994171817.20861.9729604073714626458.b4-ty@oracle.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200507222750.19113-1-bvanassche@acm.org>
References: <20200507222750.19113-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9626 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 phishscore=0 mlxscore=0 spamscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005200018
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9626 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 clxscore=1011 priorityscore=1501 mlxscore=0 impostorscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 cotscore=-2147483648
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005200018
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Thu, 7 May 2020 15:27:50 -0700, Bart Van Assche wrote:

> The ufshcd_wait_for_register() function either sleeps or spins until the
> specified register has reached the desired value. Busy-waiting is not
> only considered a bad practice but also has a bad impact on energy
> consumption. Always sleep instead of spinning by making sure that all
> ufshcd_wait_for_register() calls happen from a context where it is
> allowed to sleep. The only function call that has to be moved is the
> ufshcd_hba_stop() call in ufshcd_host_reset_and_restore().

Applied to 5.8/scsi-queue, thanks!

[1/1] scsi: ufs: Make ufshcd_wait_for_register() sleep instead of busy-waiting
      https://git.kernel.org/mkp/scsi/c/5cac1095cf28

-- 
Martin K. Petersen	Oracle Linux Engineering
