Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEFD41A904E
	for <lists+linux-scsi@lfdr.de>; Wed, 15 Apr 2020 03:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392468AbgDOBSl (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 14 Apr 2020 21:18:41 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:44032 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392461AbgDOBSf (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 14 Apr 2020 21:18:35 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03F1Eo7M069531;
        Wed, 15 Apr 2020 01:18:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=V+FGQ+Fp0ENCqGAxNIY9AUsRPmrf+3JeOdO7ro1QI18=;
 b=S/fPuJfr5OwO+QZS2ihclKnrLDCuTIUxMOp12UfyrmSXy+7qB+ebQoHrr1bwtdgkvc3O
 8NGPXclIqZ405TpmkDwVwcPwU3ya3WcIMRoMFPbIIFtmOlAup6jRENFeTeKNGbzqV1eh
 YuCL5WD8abIDwTcatZmlNEN0hpbXMHPAZK3L38q5A71NNi9pEFl5CfloljaYOQw5ej6F
 Fj/VqvlaF4D5m6DND6A1q5G8GFYDC4h/xzIDxODgybRbNYl0iqe3OohQCC9FdcSJiQgE
 Ez9FBYiWFJCRAkbesW9zHbXVjMFO9zqYR4CedqOEgOphnO47/BuVKaYe9E85D4nO4lL1 SA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 30dn95gjjd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Apr 2020 01:18:24 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03F1CxFm020563;
        Wed, 15 Apr 2020 01:18:23 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 30dn8sd7aj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Apr 2020 01:18:23 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03F1IKVS031963;
        Wed, 15 Apr 2020 01:18:21 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 14 Apr 2020 18:18:20 -0700
To:     Wu Bo <wubo40@huawei.com>
Cc:     Doug Gilbert <dgilbert@interlog.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <liuzhiqiang26@huawei.com>, <linfeilong@huawei.com>
Subject: Re: [PATCH] scsi:sg: add sg_remove_request in sg_write
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <610618d9-e983-fd56-ed0f-639428343af7@huawei.com>
Date:   Tue, 14 Apr 2020 21:18:18 -0400
In-Reply-To: <610618d9-e983-fd56-ed0f-639428343af7@huawei.com> (Wu Bo's
        message of "Tue, 14 Apr 2020 10:13:28 +0800")
Message-ID: <yq1pnc9r1gl.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9591 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=854 suspectscore=0
 bulkscore=0 malwarescore=0 phishscore=0 adultscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004150005
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9591 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 mlxscore=0 phishscore=0 spamscore=0 impostorscore=0 suspectscore=0
 mlxlogscore=929 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004150005
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Wu,

> If the __copy_from_user function return failed, it should call
> sg_remove_request in sg_write.

Applied to 5.7/scsi-fixes (by hand, another mangled patch). Thanks.

-- 
Martin K. Petersen	Oracle Linux Engineering
