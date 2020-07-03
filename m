Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE1D2213282
	for <lists+linux-scsi@lfdr.de>; Fri,  3 Jul 2020 06:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726033AbgGCEEN (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 3 Jul 2020 00:04:13 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:39592 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbgGCEEM (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 3 Jul 2020 00:04:12 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06342VZ9075964;
        Fri, 3 Jul 2020 04:04:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=MwgMiY6foXR7PQA6MvwoTTa5iOWAyRfmTGN6bICARwY=;
 b=coeD1778DytPrKrv2gwhujJQ7vLP4pKX+SDkrSNTeB6osLG2iDGSjlGnQcMgovSUKA0h
 9J9KdoZ/eZKpMiHsdxo7gJXSbGd/W/1luK1D4y3iXXbaRDma44+Pwzo7qpJo+iDNK2Ui
 neesygFBm6PW7VdEjJyyI+OCQyb6a9+1DxxQJwxse5xx3mFNbid6ev9H1hrZZx5qC8G7
 jfK8zypWXFjVmlZWE7BRtYIpW/NB1OGyIgf5Cq/rtGTmskbjQ1ZwqO9Gk2kWOD7p/dXh
 Wr7JaIFOfoNKJANdEUeps0eeZ7rkHP3D0zHjMCvAD3PF55LemG+0X+8q9SEbwC75lBUB oA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 31xx1e8hmb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 03 Jul 2020 04:04:05 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0633vtFl063416;
        Fri, 3 Jul 2020 04:04:04 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 31xg21ytdj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Jul 2020 04:04:04 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0634436H002596;
        Fri, 3 Jul 2020 04:04:03 GMT
Received: from ca-mkp.ca.oracle.com (/10.156.108.201)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 03 Jul 2020 04:04:03 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     linux-scsi@vger.kernel.org, cleech@redhat.com, lduncan@suse.com,
        james.bottomley@hansenpartnership.com,
        Mike Christie <michael.christie@oracle.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH 0/3] misc iscsi changes for 5.9
Date:   Fri,  3 Jul 2020 00:03:56 -0400
Message-Id: <159374899164.14731.6671878971518828836.b4-ty@oracle.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <1593632868-6808-1-git-send-email-michael.christie@oracle.com>
References: <1593632868-6808-1-git-send-email-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9670 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007030027
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9670 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 clxscore=1015 adultscore=0
 suspectscore=0 mlxlogscore=999 cotscore=-2147483648 lowpriorityscore=0
 malwarescore=0 phishscore=0 impostorscore=0 mlxscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2007030027
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, 1 Jul 2020 14:47:45 -0500, Mike Christie wrote:

> The following patches were made over Martin's 5.9 queue branch and
> Bob's wq patches in this thread:
> 
> https://lore.kernel.org/linux-scsi/8e09f77c-ac01-358b-0451-d4107ef5cd34@oracle.com/T/#t
> 
> They are just some cleanups and fixups and one fix for an
> issue that was found while reviewing the code (there are no
> offload and async sesison removal users).

Applied to 5.9/scsi-queue, thanks!

[1/3] scsi: iscsi: Delay freeing target_id
      https://git.kernel.org/mkp/scsi/c/e463f96bdc97
[2/3] scsi: iscsi: Optimize work queue flush use
      https://git.kernel.org/mkp/scsi/c/1d726aa6ef57
[3/3] scsi: iscsi: Remove sessdestroylist
      https://git.kernel.org/mkp/scsi/c/93bf02e5a2c2

-- 
Martin K. Petersen	Oracle Linux Engineering
