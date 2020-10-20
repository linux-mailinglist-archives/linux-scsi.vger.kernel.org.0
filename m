Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAD8E28D6AA
	for <lists+linux-scsi@lfdr.de>; Wed, 14 Oct 2020 00:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729524AbgJMWph (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 13 Oct 2020 18:45:37 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:43188 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729478AbgJMWpf (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 13 Oct 2020 18:45:35 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09DMasio072745;
        Tue, 13 Oct 2020 22:45:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=NW9Hbc3obb7PsTmWzP12beJc/s0di13ia7XQolLkkUQ=;
 b=vSzgv51mGhrh8HAzyOHZ5shziTiXKkipBDChSlQeXZqs/V/4nc9/TOOpmkhTw3YJUvx+
 cNJm4xSWft/TIj9viCNsfERCVc9SGycTjLTfaVw8w9IpBmlyTnlYiR1RxOVPG1SzumRT
 GwEhXJZ51lYz1xdxgKwQEYs3NPZlG0E4jET+Rvh/J5HqB/Jt/g9S4Y7cM1XulY0+1gyk
 cQyf0RoSMrgKxsvxljpjMhYetuMzlbOb/vNjURFwdHHY2QaVuxahFco3M6BHoCdzXeSp
 EVfVEzETwnlicIb2zWpmeWsj3AWOZqksnzm8LCB29aUnnj5MYWyyyQVjJMd9NtkzG+Rm Rg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 343vaeb2j6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 13 Oct 2020 22:45:23 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09DMaWsa049111;
        Tue, 13 Oct 2020 22:43:23 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 343pvx1srw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Oct 2020 22:43:23 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09DMhMbt014546;
        Tue, 13 Oct 2020 22:43:22 GMT
Received: from ca-mkp.ca.oracle.com (/10.156.108.201)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 13 Oct 2020 15:43:21 -0700
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Hannes Reinecke <hare@suse.de>,
        Qinglang Miao <miaoqinglang@huawei.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH -next] scsi: fcoe: simplify the return expression of fcoe_sysfs_setup
Date:   Tue, 13 Oct 2020 18:42:57 -0400
Message-Id: <160262862433.3018.8271987405972735581.b4-ty@oracle.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200921131102.93084-1-miaoqinglang@huawei.com>
References: <20200921131102.93084-1-miaoqinglang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9773 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010130158
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9773 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 clxscore=1015
 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 mlxscore=0 suspectscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010130158
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Mon, 21 Sep 2020 21:11:02 +0800, Qinglang Miao wrote:

> Simplify the return expression.

Applied to 5.10/scsi-queue, thanks!

[1/1] scsi: fcoe: Simplify the return expression of fcoe_sysfs_setup()
      https://git.kernel.org/mkp/scsi/c/de6c063fa09a

-- 
Martin K. Petersen	Oracle Linux Engineering
