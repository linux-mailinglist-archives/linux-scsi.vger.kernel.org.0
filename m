Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8CD51CDE9
	for <lists+linux-scsi@lfdr.de>; Tue, 14 May 2019 19:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbfENRZP (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 14 May 2019 13:25:15 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:57210 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbfENRZP (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 14 May 2019 13:25:15 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4EHNnSI149205;
        Tue, 14 May 2019 17:25:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=Gdvl49BkPnEJ9qWSgmczFxiIFuUvP2RhpYv36kicooE=;
 b=RRrHE1BInFnWwuaHZ3l2LUjFJKlX9xm7DBoeo05rWH6pQGe12QdFBobNPo3VIZ7My8jQ
 8RvV0RxwVtAt+/apmuFJ0EAcF37uVup4EniRSZnbszwDZ30BLqq8w1Uq1us3SM5x7/kV
 vNs1XpHRnhmpl0pDm553fgnIUkxi2Ov+RMsoqJfoSazvEUW6bjKfncMqmccrcxrg8rli
 ym7R7VdbkDFtHKb5EvvuBko41MXEvxlwlDsI594dTC0h5gNuqenlPBD37NQLLY2zUsCr
 aYjKJxSKpC/hYf4OFv+fmkzlQXgXDShSL0k0fYGNnB2i/7wjUqEUJSjkGgNINMrml6Mm iA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2sdnttqqjy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 May 2019 17:25:00 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4EHNKGW045044;
        Tue, 14 May 2019 17:24:59 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2se0tw9j7b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 May 2019 17:24:59 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x4EHOsKA030368;
        Tue, 14 May 2019 17:24:58 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 14 May 2019 10:24:54 -0700
To:     Hannes Reinecke <hare@suse.de>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        Willem Riede <osst@riede.org>
Subject: Re: [PATCHv2] osst: kill obsolete driver
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190506061915.47172-1-hare@suse.de>
Date:   Tue, 14 May 2019 13:24:52 -0400
In-Reply-To: <20190506061915.47172-1-hare@suse.de> (Hannes Reinecke's message
        of "Mon, 6 May 2019 08:19:15 +0200")
Message-ID: <yq1zhnpc5jv.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9257 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=480
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905140120
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9257 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=531 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905140120
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Hannes,

> The osst driver is becoming obsolete, as the manufacturer went out of
> business ages ago, and the maintainer has no means of testing any
> improvements anymore.  Plus these days flash drives are cheaper and
> offer a higher capacity.  So drop it completely.

Applied to 5.3/scsi-queue. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
