Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FAB9D4BFF
	for <lists+linux-scsi@lfdr.de>; Sat, 12 Oct 2019 03:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbfJLB6P (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 11 Oct 2019 21:58:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:15386 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726829AbfJLB6P (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 11 Oct 2019 21:58:15 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9C1v5bj066291;
        Fri, 11 Oct 2019 21:58:05 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vk1vtwpcf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Oct 2019 21:58:05 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x9C1spMi005948;
        Sat, 12 Oct 2019 01:58:04 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma04wdc.us.ibm.com with ESMTP id 2vejt8088j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 12 Oct 2019 01:58:04 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9C1w40J44564800
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 12 Oct 2019 01:58:04 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 314E1AE062;
        Sat, 12 Oct 2019 01:58:04 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 77438AE05C;
        Sat, 12 Oct 2019 01:58:03 +0000 (GMT)
Received: from jarvis.ext.hansenpartnership.com (unknown [9.85.184.117])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Sat, 12 Oct 2019 01:58:03 +0000 (GMT)
Message-ID: <1570845482.17735.27.camel@linux.ibm.com>
Subject: Re: [PATCH v2] scsi: core: fix uninit-value access of variable sshdr
From:   James Bottomley <jejb@linux.ibm.com>
To:     zhengbin <zhengbin13@huawei.com>, bvanassche@acm.org,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org
Date:   Fri, 11 Oct 2019 18:58:02 -0700
In-Reply-To: <1570843610-63645-1-git-send-email-zhengbin13@huawei.com>
References: <1570843610-63645-1-git-send-email-zhengbin13@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-11_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=893 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910120011
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Sat, 2019-10-12 at 09:26 +0800, zhengbin wrote:
> BTW: we can't just init sshdr->response_code, sr_do_ioctl use
> sshdr->sense_key

That's an actual bug, isn't it?

James

