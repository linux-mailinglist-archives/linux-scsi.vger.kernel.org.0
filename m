Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2751F4B1F
	for <lists+linux-scsi@lfdr.de>; Wed, 10 Jun 2020 04:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726153AbgFJCDU (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 9 Jun 2020 22:03:20 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:41988 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbgFJCDT (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 9 Jun 2020 22:03:19 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05A231B8103024;
        Wed, 10 Jun 2020 02:03:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=1hWfOTBMKjqR4hWlWXWNcErcYpndu5PUKiMJ3p6ENqI=;
 b=bXQ74eWfn0jKqeZSo/jTHIlg/2e5qwwOMAQOtQt4ZTCYGNaGXRItECxOZXn7lYeX+9Ye
 JZw7H9+jN8FFwXeel4Z1YkE0TmdkAleSpFU1iKgNnnwotHRGV4rb6FapVC2KtYpKus/w
 tO3uQwQrobjyA/zcJuh6u+eJTF4fXR+haN/hFp3FzFXYxE26UDc2QZJQNtgwabMfu7Wh
 H94Mf+B1oShykjwcoGqx4T1fM5KAVr7MpMIQVOu6kfAbMvfO6t3Mu6jliowGc7ep9jox
 2agGcdC6wq/6UHgmV1ys1LEBbBsdrtYFfKpRKtYJTct/TDLympbu2pS7aETuEzB/4215 XQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 31g3smyr28-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 10 Jun 2020 02:03:01 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05A1wORo023499;
        Wed, 10 Jun 2020 02:03:00 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 31gn27gmuv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Jun 2020 02:03:00 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05A22uHn018492;
        Wed, 10 Jun 2020 02:02:58 GMT
Received: from ca-mkp.ca.oracle.com (/10.156.108.201)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 09 Jun 2020 19:02:56 -0700
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Tyrel Datwyler <tyreld@linux.ibm.com>,
        james.bottomley@hansenpartnership.com
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linuxppc-dev@lists.ozlabs.org, brking@linux.ibm.com,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH] ibmvscsi: don't send host info in adapter info MAD after LPM
Date:   Tue,  9 Jun 2020 22:02:49 -0400
Message-Id: <159175452258.16072.4922835884463672508.b4-ty@oracle.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200603203632.18426-1-tyreld@linux.ibm.com>
References: <20200603203632.18426-1-tyreld@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9647 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 mlxscore=0
 phishscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006100013
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9647 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 cotscore=-2147483648 suspectscore=0
 spamscore=0 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006100013
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, 3 Jun 2020 15:36:32 -0500, Tyrel Datwyler wrote:

> The adatper info MAD is used to send the client info and receive the
> host info as a response. A peristent buffer is used and as such the
> client info is overwritten after the response. During the course of
> a normal adapter reset the client info is refreshed in the buffer in
> preparation for sending the adapter info MAD.
> 
> However, in the special case of LPM where we reenable the CRQ instead
> of a full CRQ teardown and reset we fail to refresh the client info in
> the adapter info buffer. As a result after Live Partition Migration
> (LPM) we erroneously report the hosts info as our own.

Applied to 5.8/scsi-queue, thanks!

[1/1] scsi: ibmvscsi: Don't send host info in adapter info MAD after LPM
      https://git.kernel.org/mkp/scsi/c/4919b33b63c8

-- 
Martin K. Petersen	Oracle Linux Engineering
