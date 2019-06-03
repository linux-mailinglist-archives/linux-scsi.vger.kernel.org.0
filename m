Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1DCC33BE4
	for <lists+linux-scsi@lfdr.de>; Tue,  4 Jun 2019 01:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbfFCXZV (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 3 Jun 2019 19:25:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58950 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726245AbfFCXZU (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 3 Jun 2019 19:25:20 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x53NM8cN035760
        for <linux-scsi@vger.kernel.org>; Mon, 3 Jun 2019 19:25:19 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2swa1177kt-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-scsi@vger.kernel.org>; Mon, 03 Jun 2019 19:25:19 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-scsi@vger.kernel.org> from <tyreld@linux.vnet.ibm.com>;
        Tue, 4 Jun 2019 00:25:18 +0100
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 4 Jun 2019 00:25:16 +0100
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x53NPF7337290314
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 3 Jun 2019 23:25:15 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1BD7BAC059;
        Mon,  3 Jun 2019 23:25:15 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B2C6FAC060;
        Mon,  3 Jun 2019 23:25:13 +0000 (GMT)
Received: from oc6857751186.ibm.com (unknown [9.85.191.102])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  3 Jun 2019 23:25:13 +0000 (GMT)
Subject: Re: [PATCH v2] scsi: ibmvscsi: Don't use rc uninitialized in
 ibmvscsi_do_work
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Tyrel Datwyler <tyreld@linux.ibm.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Michael Ellerman <mpe@ellerman.id.au>
References: <20190531185306.41290-1-natechancellor@gmail.com>
 <20190603221941.65432-1-natechancellor@gmail.com>
From:   Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Date:   Mon, 3 Jun 2019 16:25:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190603221941.65432-1-natechancellor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19060323-0072-0000-0000-00000436FB66
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011210; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01212848; UDB=6.00637410; IPR=6.00993908;
 MB=3.00027171; MTD=3.00000008; XFM=3.00000015; UTC=2019-06-03 23:25:17
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19060323-0073-0000-0000-00004C79B992
Message-Id: <6fa1dd2e-676f-b12a-5bb6-e86f5c5628fa@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-03_18:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906030157
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 06/03/2019 03:19 PM, Nathan Chancellor wrote:
> clang warns:
> 
> drivers/scsi/ibmvscsi/ibmvscsi.c:2126:7: warning: variable 'rc' is used
> uninitialized whenever switch case is taken [-Wsometimes-uninitialized]
>         case IBMVSCSI_HOST_ACTION_NONE:
>              ^~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/scsi/ibmvscsi/ibmvscsi.c:2151:6: note: uninitialized use occurs
> here
>         if (rc) {
>             ^~
> 
> Initialize rc to zero in the case statements that clang mentions so that
> the atomic_set and dev_err statement don't trigger for them.
> 
> Fixes: 035a3c4046b5 ("scsi: ibmvscsi: redo driver work thread to use enum action states")
> Link: https://github.com/ClangBuiltLinux/linux/issues/502
> Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Acked-by: Tyrel Datwyler <tyreld@linux.ibm.com>

