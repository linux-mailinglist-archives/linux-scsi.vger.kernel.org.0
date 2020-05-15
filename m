Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3FC1D42B9
	for <lists+linux-scsi@lfdr.de>; Fri, 15 May 2020 03:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgEOBKg (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 14 May 2020 21:10:36 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:39274 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbgEOBKg (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 14 May 2020 21:10:36 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04F11R94104697;
        Fri, 15 May 2020 01:10:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=Nb7B20FebWpIMAB7LrCXaegslYRl7DykfoSctEbf2hc=;
 b=d+L+kpiZUL82jJSB8z1JNH3zdPLYmxRKwYIzUn1ugKyJUFmefRt1i/b36GMjMpkVL1qa
 QEXbdLsEvQ2mcwJ93HSXFwXDxL/SwR1UoPmRDxVsgWDzdVX2C0ZkG85w8flr8eAa7X14
 /K2q9E8cRSVf2DHkt8E2+J0Hd6oKpgnOsOb1LhRiu35jVVAm7okWXCkWI2qn2Uf5B/jK
 Ia5xk/kzV7k++o/GqoHwq/Ed3eGAZcWTwhwWUS2Zxc4/nLvaDaBSnpvmpVeXJKP/jEA7
 w9M6iYHGs1yM+ybObfWYIghUUwrr/dZ7t4B3ClipUImtRh5KqiyTVBHRpKhUic38UES0 PQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 3100xwpq6e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 15 May 2020 01:10:34 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04F146NS014910;
        Fri, 15 May 2020 01:10:34 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 3100yds32t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 May 2020 01:10:34 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04F1AXCr006136;
        Fri, 15 May 2020 01:10:33 GMT
Received: from ca-mkp.ca.oracle.com (/10.156.108.201)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 14 May 2020 18:10:33 -0700
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Damien Le Moal <damien.lemoal@wdc.com>, linux-scsi@vger.kernel.org
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] sd: Signal drive managed SMR disks
Date:   Thu, 14 May 2020 21:10:27 -0400
Message-Id: <158950485295.8169.18329502302880610281.b4-ty@oracle.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200514081953.1252087-1-damien.lemoal@wdc.com>
References: <20200514081953.1252087-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9621 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 phishscore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=979 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005150007
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9621 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=999 clxscore=1015 cotscore=-2147483648
 mlxscore=0 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005150007
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Thu, 14 May 2020 17:19:53 +0900, Damien Le Moal wrote:

> Print a message indicating that a disk is a drive-managed SMR model when
> such drive is found using the ZONED filed of the Block Device
> Characteristics VPD page (IDENTIFY data on ATA side).

Applied to 5.8/scsi-queue, thanks!

[1/1] scsi: sd: Signal drive managed SMR disks
      https://git.kernel.org/mkp/scsi/c/0bd735df7681

-- 
Martin K. Petersen	Oracle Linux Engineering
