Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62D4323C2F6
	for <lists+linux-scsi@lfdr.de>; Wed,  5 Aug 2020 03:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgHEBRu (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 4 Aug 2020 21:17:50 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50614 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727019AbgHEBRu (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 4 Aug 2020 21:17:50 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0751HZSw179256;
        Wed, 5 Aug 2020 01:17:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=wj1YZz+pmf+HCinFD32xDTKdLA54ExTNkBxrPLXddmQ=;
 b=bOeyjoaNDx9KNB4TbcVi9NIZkqF8PMnM5Wbg4p228ILae6BdfaocQ0ozWwB0eeBtgT+C
 G2JZjeT4TPf/RXInl1uzzAoFHwBLAuKPV3BKDPvly3Be3zaKOTLKa+fYN2wz2lBAULSs
 DhAGYkRIs3p4uW6af9gAglpJ+pa6VI2ZYmYfQEcqELCXottEbS0GohJOA7LYdxMjZWwj
 TTuQFODlQAYXTVXLA7I8ZCRkWtdzVQSFe/4XyrqAF8qgdrRHruDyIhRAEBtCxqfixTCJ
 qCSd68bjTzWb3UVLU1zumn/HXv170ljtu6TFsqK2+nNC90qADs0bfzxZZajYStfAQrV6 Ug== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 32pdnqanxs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 05 Aug 2020 01:17:37 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 075198pU088113;
        Wed, 5 Aug 2020 01:17:37 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 32p5gt1mu2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Aug 2020 01:17:36 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0751HY2l014758;
        Wed, 5 Aug 2020 01:17:35 GMT
Received: from ca-mkp.ca.oracle.com (/10.156.108.201)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 04 Aug 2020 18:17:34 -0700
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     jejb@linux.vnet.ibm.com, chenxiang <chenxiang66@hisilicon.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, john.garry@huawei.com
Subject: Re: [PATCH] scsi: scsi_transport_sas: add spaces around binary operator "|"
Date:   Tue,  4 Aug 2020 21:17:27 -0400
Message-Id: <159659019689.15726.14556115562118184753.b4-ty@oracle.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <1596454442-220565-1-git-send-email-chenxiang66@hisilicon.com>
References: <1596454442-220565-1-git-send-email-chenxiang66@hisilicon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9703 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 phishscore=0 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008050008
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9703 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 adultscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008050009
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Mon, 3 Aug 2020 19:34:02 +0800, chenxiang wrote:

> According to coding style, need to use one space around binary operator "|",
> so add spaces around it.

Applied to 5.9/scsi-queue, thanks!

[1/1] scsi: scsi_transport_sas: Add spaces around binary operator "|"
      https://git.kernel.org/mkp/scsi/c/8a8fb8977ea2

-- 
Martin K. Petersen	Oracle Linux Engineering
