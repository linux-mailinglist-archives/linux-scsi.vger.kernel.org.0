Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC7F26B9B0
	for <lists+linux-scsi@lfdr.de>; Wed, 16 Sep 2020 04:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgIPCMM (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 15 Sep 2020 22:12:12 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:49074 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbgIPCMK (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 15 Sep 2020 22:12:10 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08G292aH174628;
        Wed, 16 Sep 2020 02:12:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : mime-version :
 content-type; s=corp-2020-01-29;
 bh=NY0n7DG7EIoRigqcLado++D3OcECAt8yHsd35vel328=;
 b=cehS8+DRCxUo5HaVjQSHHapV7ypNGXRrcCbSqUrfIsyTUx6ftSDzLINIPnqhmdYIyCY9
 nJ6G+Bx7ppL0+EeyQQi75/uG1RjLGa9G0+UJlMQCQ2oNo5B5OjYc2uLgDkDFASLIc/jF
 WDY+vL0s/cDIqRQDwBeWkvi+wSPJIwzgmWvTNK9Y7J7EuVNALl1lJ83XtuAtQCmUicLm
 Ni+x2bPQMplvUCPbvTxez/LlR/Y6omnsrBTtKH1HWmITGnC4XB+FOX0m3psXBx88u2Ls
 iLW3XNieak6+pO+aYXWMHt0hrSlzv3kZsnb3f6ZZuyca432EUiQeiYUM8vCyHZccriyp MQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 33gp9m8c9g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Sep 2020 02:12:09 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08G2BSLr021414;
        Wed, 16 Sep 2020 02:12:08 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 33h886px5e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Sep 2020 02:12:08 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08G2C8WK027562;
        Wed, 16 Sep 2020 02:12:08 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 16 Sep 2020 02:12:07 +0000
To:     Alex Dewar <alex.dewar90@gmail.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 0/3] scsi: mpt: Refactor and port to dma_* interface
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1ft7ixyg8.fsf@ca-mkp.ca.oracle.com>
References: <20200903152832.484908-1-alex.dewar90@gmail.com>
Date:   Tue, 15 Sep 2020 22:12:06 -0400
In-Reply-To: <20200903152832.484908-1-alex.dewar90@gmail.com> (Alex Dewar's
        message of "Thu, 3 Sep 2020 16:28:29 +0100")
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9745 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=1 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009160012
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9745 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 spamscore=0 priorityscore=1501 suspectscore=1 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009160012
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Alex,

> Any feedback would be greatly appreciated!

Have you tested your changes?

-- 
Martin K. Petersen	Oracle Linux Engineering
