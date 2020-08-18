Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D47A3247C81
	for <lists+linux-scsi@lfdr.de>; Tue, 18 Aug 2020 05:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbgHRDMt (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 17 Aug 2020 23:12:49 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:48072 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgHRDMr (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 17 Aug 2020 23:12:47 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07I38Bok032585;
        Tue, 18 Aug 2020 03:12:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=Gp+9FN/GfaAwaEU6Mlvk7T6C1H9O9JLyddlNYBJndG4=;
 b=JrzIVnbSAVTrQh/yx2IKPjVyWVp5gYp76wmvoMaUmv5zOTWJ4VTUkeOLtQkVyCecIbhj
 Kjgeva9JcFLt0sVbt6uPazfc9qwMvkOflvTbs+MwHxAn4fGOGPSbVUSaBhdG8BXDtdxj
 2mGd+Erqc1f+iwgu87jZdaHJBzLO06L2hRp4ydimMnyfni0gFVuRF6mmSMcsAI4MxFor
 WcyaHbxm1smAPqLxKhHCh8bH3O3Ocgx/CdNZk63py6ExdUW+6hppJfRdZE4jV9L1N00/
 ztPtaOTA5RcN9I6jw7AIhy9+0q0vAMNMMswNVmkNvWEnXHJgdAAqang60tJq8nCMNApK gw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 32x7nma5ev-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 18 Aug 2020 03:12:37 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07I387Zk131495;
        Tue, 18 Aug 2020 03:12:36 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 32xs9mf4aw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Aug 2020 03:12:36 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07I3CZB5021349;
        Tue, 18 Aug 2020 03:12:36 GMT
Received: from ca-mkp.ca.oracle.com (/10.156.108.201)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 17 Aug 2020 20:12:35 -0700
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Venkat Gopalakrishnan <venkatg@codeaurora.org>,
        Avri Altman <avri.altman@wdc.com>, linux-scsi@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Can Guo <cang@codeaurora.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/2] scsi: ufs: Fix interrupt error message for shared interrupts
Date:   Mon, 17 Aug 2020 23:12:23 -0400
Message-Id: <159772029326.19587.16153051053275556341.b4-ty@oracle.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200811133936.19171-1-adrian.hunter@intel.com>
References: <20200811133936.19171-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9716 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 spamscore=0
 mlxscore=0 mlxlogscore=751 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008180022
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9716 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 mlxscore=0 mlxlogscore=745
 lowpriorityscore=0 bulkscore=0 phishscore=0 malwarescore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008180022
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Tue, 11 Aug 2020 16:39:35 +0300, Adrian Hunter wrote:

> The interrupt might be shared, in which case it is not an error for the
> interrupt handler to be called when the interrupt status is zero, so
> don't print the message unless there was enabled interrupt status.

Applied to 5.9/scsi-fixes, thanks!

[1/2] scsi: ufs: Fix interrupt error message for shared interrupts
      https://git.kernel.org/mkp/scsi/c/6337f58cec03
[2/2] scsi: ufs: Improve interrupt handling for shared interrupts
      https://git.kernel.org/mkp/scsi/c/127d5f7c4b65

-- 
Martin K. Petersen	Oracle Linux Engineering
