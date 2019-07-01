Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4A6238BA1
	for <lists+linux-scsi@lfdr.de>; Fri,  7 Jun 2019 15:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728756AbfFGN2F (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 7 Jun 2019 09:28:05 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:43118 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727840AbfFGN2F (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 7 Jun 2019 09:28:05 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x57DOAaO183017;
        Fri, 7 Jun 2019 13:26:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=Kn1ssFbA72f9kM6B6tm8ADY7maOuNtpoUji1D+ceW28=;
 b=iCfMHinPpIkDuxBSM/9wk75OOAPVVO09cL/g4U6al1PnjZv5R837JlUG93ehH9nU9THd
 +cFS4Sqg5+1GJQZIoPlx7eCz2m59HUtz+s6cTKCHzVkg9DKWc2FdgzsOrAMuD8XOJVPP
 zWwsP9ZWNUKAvAOQlCjmImIRCgwEYtX5acIB8k3z9cUqTiw9iwe5JH0yvDdFJBn9r/Lt
 3UqtYt7dvdHhuienzMBi/Z8GRtIR8+tjHU+NfvHM2iVx7s0Pnsh25K6UrRHbvISxn45i
 4e8MeCxSBLZ8VCvg31ZaE5fq3x4YrtMnZieUANO/YCKHxEHqNhTl8kr8S8ujrubes65y Tg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 2suevdxh7p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jun 2019 13:26:54 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x57DQ0cN056067;
        Fri, 7 Jun 2019 13:26:53 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2swngk0y9s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jun 2019 13:26:53 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x57DQj2V029712;
        Fri, 7 Jun 2019 13:26:46 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 07 Jun 2019 06:26:44 -0700
To:     John Garry <john.garry@huawei.com>
Cc:     <jejb@linux.ibm.com>, <intel-linux-scu@intel.com>,
        <artur.paszkiewicz@intel.com>, <jinpu.wang@profitbricks.com>,
        <lindar_liu@usish.com>, <yanaijie@huawei.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <hare@suse.de>
Subject: Re: [PATCH] scsi: libsas, lldds: Use dev_is_expander()
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1559751143-168560-1-git-send-email-john.garry@huawei.com>
        <yq1k1dymkyh.fsf@oracle.com>
Date:   Fri, 07 Jun 2019 09:26:42 -0400
In-Reply-To: <yq1k1dymkyh.fsf@oracle.com> (Martin K. Petersen's message of
        "Thu, 06 Jun 2019 18:02:14 -0400")
Message-ID: <yq1v9xhjzl9.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9280 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=607
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906070095
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9280 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=668 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906070095
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


John,

>> Many times in libsas, and in LLDDs which use libsas, the check for an
>> expander device is re-implemented or open coded.
>
> Applied to 5.3/scsi-queue, thanks.

Dropped again. Breaks isci. Please fix.

-- 
Martin K. Petersen	Oracle Linux Engineering
