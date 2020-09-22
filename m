Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10776273986
	for <lists+linux-scsi@lfdr.de>; Tue, 22 Sep 2020 05:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728975AbgIVD6C (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 21 Sep 2020 23:58:02 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:42290 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728936AbgIVD54 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 21 Sep 2020 23:57:56 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08M3nuWM149283;
        Tue, 22 Sep 2020 03:57:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=8iV7zBNWi+8d727RnMjnUhiIL/wE84I9jsQchwXcb9U=;
 b=TZrpoHnidJDvfKU/Ze5Wzb5VU4zfrRjIIf2OPLtW5Tl0IUe6Kyah+g/rWKb5LxAuSoY5
 QwVHHHASojA/KI5h6zpRTmVZqpOhTyXke1e/erO2W8W92CUki5Rl+GPgasf07pj8t9r0
 ZABR48t4QJRfLfaOiWvIPAklFU6RdisInc2tGJfY/Bqd0bX4cE/PioNlnh+YwT3e8tGB
 xy84+icgatkkxtJ2wxc2t+97Fv3Tkxn77+DUpBnQik3wHjnfhINyZPY2SdynjdQdPBLy
 QNXOJf6CIh1q0OLFX0N/uoYioFDDUFVFpWBToBA56qxFaOFwt6xsAS5k2R3gErH/wToq eA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 33n7gad5tx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Sep 2020 03:57:43 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08M3tLeJ020863;
        Tue, 22 Sep 2020 03:57:42 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 33nuwxk79b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Sep 2020 03:57:42 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08M3vfBq012294;
        Tue, 22 Sep 2020 03:57:41 GMT
Received: from ca-mkp.ca.oracle.com (/10.156.108.201)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 21 Sep 2020 20:57:39 -0700
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     linux-scsi@vger.kernel.org, Jason Yan <yanaijie@huawei.com>,
        jejb@linux.ibm.com, willy@infradead.org
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH] scsi: sym53c8xx_2: remove unneeded semicolon
Date:   Mon, 21 Sep 2020 23:57:06 -0400
Message-Id: <160074695007.411.5509374853655539171.b4-ty@oracle.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200911091031.2937834-1-yanaijie@huawei.com>
References: <20200911091031.2937834-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9751 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009220031
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9751 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 bulkscore=0
 mlxscore=0 suspectscore=0 impostorscore=0 malwarescore=0 spamscore=0
 phishscore=0 mlxlogscore=999 clxscore=1015 adultscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009220030
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Fri, 11 Sep 2020 17:10:31 +0800, Jason Yan wrote:

> This addresses the following coccinelle warning:
> 
> drivers/scsi/sym53c8xx_2/sym_fw.c:372:3-4: Unneeded semicolon
> drivers/scsi/sym53c8xx_2/sym_fw.c:480:3-4: Unneeded semicolon
> drivers/scsi/sym53c8xx_2/sym_fw.c:536:2-3: Unneeded semicolon

Applied to 5.10/scsi-queue, thanks!

[1/1] scsi: sym53c8xx_2: Remove unneeded semicolon
      https://git.kernel.org/mkp/scsi/c/8d4089cdc313

-- 
Martin K. Petersen	Oracle Linux Engineering
