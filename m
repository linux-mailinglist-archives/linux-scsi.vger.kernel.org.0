Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7FC257FCA
	for <lists+linux-scsi@lfdr.de>; Mon, 31 Aug 2020 19:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729095AbgHaRly (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 31 Aug 2020 13:41:54 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:49296 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729084AbgHaRlv (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 31 Aug 2020 13:41:51 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07VHSonc072910;
        Mon, 31 Aug 2020 17:41:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=6Brqgu2ha0262GWeDozDJjgeaOVDJ0MjlldhBkpBzjU=;
 b=nz+v/yyhhjI3F8XizagbN0QvA+R/LlljO7IW/u8IM6pBYlkusA4c6xHJLOEcVeTtoF6O
 9DuP3+GxuHyipLfbT3FJLFxWF0TWOr2jPWSUb2Ir9IbjjQNIhEKE+JcBzwVjX/bRZ7tM
 slUMkophWow2UhANkrNNYRA5fiYeZttjEquk9be+OtMcIERLoz1dN/yDz00VIjd78qCs
 M1IYQ/4mD6KnechlP2k8JS2dsYPZ9GHRUAWjPGx6EYrlUdrtUCY8uWsrBavHDrKI+zbq
 7P1bI3XMNA8RtJ58pILFyrbSWFYGyArjuPuwKbrCRVpavh0DozwDIxKaOowSfGKpEBOA zA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 337eeqqmgy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 31 Aug 2020 17:41:25 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07VHevqf029568;
        Mon, 31 Aug 2020 17:41:25 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 3380sqbrv6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Aug 2020 17:41:25 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07VHfNSM005103;
        Mon, 31 Aug 2020 17:41:23 GMT
Received: from ca-mkp.ca.oracle.com (/10.156.108.201)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 31 Aug 2020 10:41:22 -0700
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     davem@davemloft.net, jejb@linux.ibm.com, arkadiusz@drabczyk.org,
        praveenm@chelsio.com,
        Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, tianjia.zhang@alibaba.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: csiostor: Fix wrong return value in csio_hw_prep_fw()
Date:   Mon, 31 Aug 2020 13:41:09 -0400
Message-Id: <159889566025.22322.13946426443930971626.b4-ty@oracle.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200802111531.5065-1-tianjia.zhang@linux.alibaba.com>
References: <20200802111531.5065-1-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9730 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=950 adultscore=0
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008310105
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9730 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 impostorscore=0 mlxlogscore=964 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008310104
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Sun, 2 Aug 2020 19:15:31 +0800, Tianjia Zhang wrote:

> On an error exit path, a negative error code should be returned
> instead of a positive return value.

Applied to 5.10/scsi-queue, thanks!

[1/1] scsi: csiostor: Fix wrong return value in csio_hw_prep_fw()
      https://git.kernel.org/mkp/scsi/c/44f4daf8678a

-- 
Martin K. Petersen	Oracle Linux Engineering
