Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A64DA57A7C
	for <lists+linux-scsi@lfdr.de>; Thu, 27 Jun 2019 06:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbfF0EMT (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 27 Jun 2019 00:12:19 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:55600 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfF0EMT (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 27 Jun 2019 00:12:19 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5R48qfZ112041;
        Thu, 27 Jun 2019 04:12:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=4eHBST+KWU/UpuOTgQo87PYPHx6YIy7K7Pi6c3Pvx3k=;
 b=kWGZjsk1ySqWu1mv4M4JpjiLediz4+TIKY+O6kkI1FP5EU6D7Gz0vbSCl2bFkEI74I+D
 4MpTx3uD1jNz+DNm5i10EmVu0TFCVBgee8Rf/W/N7HVZwRsoSDydYmtwIuotxSsc7fXL
 VFd/z/hcnT0BsUpE+kHi1EiUl4V8bA2PbrIsza+Qp983IGUqaCviO/tKcJFciDQyj1/9
 WTNdXuM3xZ7SHEK4DyR1iRFdYByoFPVH+EqL2cEnB3FuCdJioGiMzLaF8E/oAAhp6bi5
 FyITVqwVVNO2vwgXJjPL1nbESnsJFDHsvsmuFgMnzhcD/RmYRw0cdZs/2aBtNuhXKKO1 mA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2t9brtdtd7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jun 2019 04:12:14 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5R4AmD2021776;
        Thu, 27 Jun 2019 04:12:13 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 2t9p6v407p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jun 2019 04:12:13 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5R4C5Fw031648;
        Thu, 27 Jun 2019 04:12:11 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 26 Jun 2019 21:12:05 -0700
To:     Himanshu Madhani <hmadhani@marvell.com>
Cc:     <James.Bottomley@HansenPartnership.com>,
        <martin.petersen@oracle.com>, <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH v3 0/3] qla2xxx: Fix crashes with FC-NVMe devices
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190621165024.23874-1-hmadhani@marvell.com>
Date:   Thu, 27 Jun 2019 00:12:03 -0400
In-Reply-To: <20190621165024.23874-1-hmadhani@marvell.com> (Himanshu Madhani's
        message of "Fri, 21 Jun 2019 09:50:21 -0700")
Message-ID: <yq1blyjk6p8.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9300 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=460
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906270046
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9300 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=526 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906270046
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Himanshu,

> This series fixes crash during abort handling with FC-NVMe devices.
> Also, we discovered race condition between nvme command and ls
> completion with FC-NVMe devices.

Applied to 5.3/scsi-queue.

-- 
Martin K. Petersen	Oracle Linux Engineering
