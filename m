Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB68A2EA34
	for <lists+linux-scsi@lfdr.de>; Thu, 30 May 2019 03:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbfE3B0S (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 29 May 2019 21:26:18 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:50270 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbfE3B0R (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 29 May 2019 21:26:17 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4U1OsWG161537;
        Thu, 30 May 2019 01:26:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=G0/qiuCxh/sxM7hIGcly2VU26ZrBh/rTX3lxFUwRDQg=;
 b=Zi2GSq0c4vRlt/ITTz1mEvNBsLaAskRDk+LdesDD4NeEDb48A1s2J42uOJND2EFuMTov
 RJD+FyY9/Qg5B97i/tChsvnnzkScybHyD0syG6nsxczvTqs6PodRnuScwA6Kid2KfZF9
 EP2Z9GNCeQYbZYD+ATQqCfx449UkCaHM7d3A3JL4uOMVZUwdGbcTsqjtMHhRD4qyv/a2
 2yXSodwMwgTdXiyRRga3NmYCB7C6oRU9Lu0JkHLbc2XKuPT9YsBg7rFeE9JG0d5miEEw
 Ym6iLpcYMck/nu9hibsU1ikKS95CaXMJTiWPpziI/2BMxOLJ9Cq7HnmGpdSpgu+qpv+V FQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2spxbqd3y6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 01:26:14 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4U1O2rZ120632;
        Thu, 30 May 2019 01:24:14 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2sr31vk51b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 01:24:14 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4U1ODvL028036;
        Thu, 30 May 2019 01:24:13 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 29 May 2019 18:24:13 -0700
To:     James Smart <jsmart2021@gmail.com>
Cc:     linux-scsi@vger.kernel.org
Subject: Re: [PATCH 00/21] lpfc: Update lpfc to revision 12.2.0.3
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190522004911.573-1-jsmart2021@gmail.com>
Date:   Wed, 29 May 2019 21:24:11 -0400
In-Reply-To: <20190522004911.573-1-jsmart2021@gmail.com> (James Smart's
        message of "Tue, 21 May 2019 17:48:50 -0700")
Message-ID: <yq1blzk20qs.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9272 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=754
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905300009
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9272 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=801 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905300009
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


James,

> Update lpfc to revision 12.2.0.3

Applied to 5.3/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
