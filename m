Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F21F257FCD
	for <lists+linux-scsi@lfdr.de>; Mon, 31 Aug 2020 19:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729033AbgHaRlp (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 31 Aug 2020 13:41:45 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:49146 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728426AbgHaRlh (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 31 Aug 2020 13:41:37 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07VHSoGg072918;
        Mon, 31 Aug 2020 17:41:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=cJ29e7cynhcKkOTyN8hFFiHPNP6/A4cywqrTCy+U+yE=;
 b=j4mFWI31L7jxzSDqXxDfaZUvH0kjB6Cc9Ndn5YXmYync/lm4glqwi0euI3I61/8M1N8f
 qYzd3PLU2phFOr0N+VBR8lFMrKEyk8DdVOGy+laDboe6XCsAtIQKqIwakoRclJaOdCa2
 x0w/xP3qGekaoHdvYBm4wVXyBV9ibtXg1I3xD9wFpBEdbin4WpfBssQdodXbSlG1FmOE
 XZFIyTqq65yEn+QXEEP904WBLFa66729xeZZEYlTBScGSy76Fs/k+tJhhUo82VijqnUw
 JNwZrGfHTbI59rEFEjHaI84WL/j0PeHVhMm1WDREDfooGjKpmvffnBPeEjglg8r1Jy7r xA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 337eeqqmh9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 31 Aug 2020 17:41:30 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07VHeZ3D165662;
        Mon, 31 Aug 2020 17:41:29 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 3380x0v12t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Aug 2020 17:41:29 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07VHfS0a018285;
        Mon, 31 Aug 2020 17:41:28 GMT
Received: from ca-mkp.ca.oracle.com (/10.156.108.201)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 31 Aug 2020 10:41:28 -0700
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Tong Zhang <ztong0001@gmail.com>, jejb@linux.ibm.com,
        linux-scsi@vger.kernel.org, hare@suse.com,
        linux-kernel@vger.kernel.org
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] scsi: aic7xxx: fix error code handling
Date:   Mon, 31 Aug 2020 13:41:14 -0400
Message-Id: <159889566024.22322.660033328477615085.b4-ty@oracle.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200816070242.978839-1-ztong0001@gmail.com>
References: <20200816070242.978839-1-ztong0001@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9730 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 phishscore=0
 mlxlogscore=899 adultscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008310105
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9730 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 impostorscore=0 mlxlogscore=919 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008310104
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Sun, 16 Aug 2020 03:02:42 -0400, Tong Zhang wrote:

> ahc_linux_queue_recovery_cmd returns SUCCESS(0x2002) or FAIL(0x2003),
> but the caller is checking error case using !=0

Applied to 5.10/scsi-queue, thanks!

[1/1] scsi: aic7xxx: Fix error code handling
      https://git.kernel.org/mkp/scsi/c/715f43c66c45

-- 
Martin K. Petersen	Oracle Linux Engineering
