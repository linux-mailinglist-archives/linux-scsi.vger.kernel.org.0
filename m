Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 465EC8DE23
	for <lists+linux-scsi@lfdr.de>; Wed, 14 Aug 2019 21:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729179AbfHNTye (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 14 Aug 2019 15:54:34 -0400
Received: from mga09.intel.com ([134.134.136.24]:6352 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726951AbfHNTyd (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 14 Aug 2019 15:54:33 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Aug 2019 12:54:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,386,1559545200"; 
   d="gz'50?scan'50,208,50";a="260604583"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 14 Aug 2019 12:54:22 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hxzLi-000INT-7L; Thu, 15 Aug 2019 03:54:22 +0800
Date:   Thu, 15 Aug 2019 03:53:40 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Mark Balantzyan <mbalant3@gmail.com>
Cc:     kbuild-all@01.org, sathya.prakash@broadcom.com,
        suganath-prabu.subramani@broadcom.com,
        MPT=FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Balantzyan <mbalant3@gmail.com>
Subject: Re: [PATCH] lsilogic mpt fusion: mptctl: Fixed race condition around
 mptctl_id variable using mutexes
Message-ID: <201908150311.l4EskUYZ%lkp@intel.com>
References: <20190814151241.37141-1-mbalant3@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="3r6mift7r7cv6cpv"
Content-Disposition: inline
In-Reply-To: <20190814151241.37141-1-mbalant3@gmail.com>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


--3r6mift7r7cv6cpv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Mark,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[cannot apply to v5.3-rc4 next-20190814]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Mark-Balantzyan/lsilogic-mpt-fusion-mptctl-Fixed-race-condition-around-mptctl_id-variable-using-mutexes/20190815-023617
config: parisc-allmodconfig (attached as .config)
compiler: hppa-linux-gcc (GCC) 7.4.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.4.0 make.cross ARCH=parisc 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/message/fusion/mptctl.c: In function 'mptctl_do_mpt_command':
>> drivers/message/fusion/mptctl.c:2300:4: warning: this 'else' clause does not guard... [-Wmisleading-indentation]
     } else
       ^~~~
   drivers/message/fusion/mptctl.c:2302:3: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'else'
      mpt_put_msg_frame(mptctl_id, ioc, mf);
      ^~~~~~~~~~~~~~~~~

vim +/else +2300 drivers/message/fusion/mptctl.c

^1da177e4c3f41 Linus Torvalds  2005-04-16  1815  
^1da177e4c3f41 Linus Torvalds  2005-04-16  1816  /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
^1da177e4c3f41 Linus Torvalds  2005-04-16  1817  /* Worker routine for the IOCTL MPTCOMMAND and MPTCOMMAND32 (sparc) commands.
^1da177e4c3f41 Linus Torvalds  2005-04-16  1818   *
^1da177e4c3f41 Linus Torvalds  2005-04-16  1819   * Outputs:	None.
^1da177e4c3f41 Linus Torvalds  2005-04-16  1820   * Return:	0 if successful
fc1323bb75ef8a Joe Perches     2008-02-03  1821   *		-EBUSY  if previous command timeout and IOC reset is not complete.
^1da177e4c3f41 Linus Torvalds  2005-04-16  1822   *		-EFAULT if data unavailable
^1da177e4c3f41 Linus Torvalds  2005-04-16  1823   *		-ENODEV if no such device/adapter
^1da177e4c3f41 Linus Torvalds  2005-04-16  1824   *		-ETIME	if timer expires
^1da177e4c3f41 Linus Torvalds  2005-04-16  1825   *		-ENOMEM if memory allocation error
^1da177e4c3f41 Linus Torvalds  2005-04-16  1826   *		-EPERM if SCSI I/O and target is untagged
^1da177e4c3f41 Linus Torvalds  2005-04-16  1827   */
^1da177e4c3f41 Linus Torvalds  2005-04-16  1828  static int
^1da177e4c3f41 Linus Torvalds  2005-04-16  1829  mptctl_do_mpt_command (struct mpt_ioctl_command karg, void __user *mfPtr)
^1da177e4c3f41 Linus Torvalds  2005-04-16  1830  {
^1da177e4c3f41 Linus Torvalds  2005-04-16  1831  	MPT_ADAPTER	*ioc;
^1da177e4c3f41 Linus Torvalds  2005-04-16  1832  	MPT_FRAME_HDR	*mf = NULL;
^1da177e4c3f41 Linus Torvalds  2005-04-16  1833  	MPIHeader_t	*hdr;
^1da177e4c3f41 Linus Torvalds  2005-04-16  1834  	char		*psge;
^1da177e4c3f41 Linus Torvalds  2005-04-16  1835  	struct buflist	bufIn;	/* data In buffer */
^1da177e4c3f41 Linus Torvalds  2005-04-16  1836  	struct buflist	bufOut; /* data Out buffer */
^1da177e4c3f41 Linus Torvalds  2005-04-16  1837  	dma_addr_t	dma_addr_in;
^1da177e4c3f41 Linus Torvalds  2005-04-16  1838  	dma_addr_t	dma_addr_out;
^1da177e4c3f41 Linus Torvalds  2005-04-16  1839  	int		sgSize = 0;	/* Num SG elements */
^1da177e4c3f41 Linus Torvalds  2005-04-16  1840  	int		iocnum, flagsLength;
^1da177e4c3f41 Linus Torvalds  2005-04-16  1841  	int		sz, rc = 0;
^1da177e4c3f41 Linus Torvalds  2005-04-16  1842  	int		msgContext;
^1da177e4c3f41 Linus Torvalds  2005-04-16  1843  	u16		req_idx;
^1da177e4c3f41 Linus Torvalds  2005-04-16  1844  	ulong 		timeout;
ea2a788de4ce5e Kashyap, Desai  2009-05-29  1845  	unsigned long	timeleft;
793955f549c710 Eric Moore      2007-01-29  1846  	struct scsi_device *sdev;
ea2a788de4ce5e Kashyap, Desai  2009-05-29  1847  	unsigned long	 flags;
ea2a788de4ce5e Kashyap, Desai  2009-05-29  1848  	u8		 function;
^1da177e4c3f41 Linus Torvalds  2005-04-16  1849  
ab37128797148e Eric Moore      2007-09-29  1850  	/* bufIn and bufOut are used for user to kernel space transfers
ab37128797148e Eric Moore      2007-09-29  1851  	 */
^1da177e4c3f41 Linus Torvalds  2005-04-16  1852  	bufIn.kptr = bufOut.kptr = NULL;
ab37128797148e Eric Moore      2007-09-29  1853  	bufIn.len = bufOut.len = 0;
^1da177e4c3f41 Linus Torvalds  2005-04-16  1854  
^1da177e4c3f41 Linus Torvalds  2005-04-16  1855  	if (((iocnum = mpt_verify_adapter(karg.hdr.iocnum, &ioc)) < 0) ||
^1da177e4c3f41 Linus Torvalds  2005-04-16  1856  	    (ioc == NULL)) {
29dd3609f2fc70 Eric Moore      2007-09-14  1857  		printk(KERN_DEBUG MYNAM "%s::mptctl_do_mpt_command() @%d - ioc%d not found!\n",
09120a8cd38dbd Prakash, Sathya 2007-07-24  1858  				__FILE__, __LINE__, iocnum);
^1da177e4c3f41 Linus Torvalds  2005-04-16  1859  		return -ENODEV;
^1da177e4c3f41 Linus Torvalds  2005-04-16  1860  	}
ea2a788de4ce5e Kashyap, Desai  2009-05-29  1861  
ea2a788de4ce5e Kashyap, Desai  2009-05-29  1862  	spin_lock_irqsave(&ioc->taskmgmt_lock, flags);
ea2a788de4ce5e Kashyap, Desai  2009-05-29  1863  	if (ioc->ioc_reset_in_progress) {
ea2a788de4ce5e Kashyap, Desai  2009-05-29  1864  		spin_unlock_irqrestore(&ioc->taskmgmt_lock, flags);
29dd3609f2fc70 Eric Moore      2007-09-14  1865  		printk(KERN_ERR MYNAM "%s@%d::mptctl_do_mpt_command - "
ea2a788de4ce5e Kashyap, Desai  2009-05-29  1866  			"Busy with diagnostic reset\n", __FILE__, __LINE__);
^1da177e4c3f41 Linus Torvalds  2005-04-16  1867  		return -EBUSY;
^1da177e4c3f41 Linus Torvalds  2005-04-16  1868  	}
ea2a788de4ce5e Kashyap, Desai  2009-05-29  1869  	spin_unlock_irqrestore(&ioc->taskmgmt_lock, flags);
^1da177e4c3f41 Linus Torvalds  2005-04-16  1870  
e819cdb198319c Dan Carpenter   2015-07-03  1871  	/* Basic sanity checks to prevent underflows or integer overflows */
e819cdb198319c Dan Carpenter   2015-07-03  1872  	if (karg.maxReplyBytes < 0 ||
e819cdb198319c Dan Carpenter   2015-07-03  1873  	    karg.dataInSize < 0 ||
e819cdb198319c Dan Carpenter   2015-07-03  1874  	    karg.dataOutSize < 0 ||
e819cdb198319c Dan Carpenter   2015-07-03  1875  	    karg.dataSgeOffset < 0 ||
e819cdb198319c Dan Carpenter   2015-07-03  1876  	    karg.maxSenseBytes < 0 ||
e819cdb198319c Dan Carpenter   2015-07-03  1877  	    karg.dataSgeOffset > ioc->req_sz / 4)
e819cdb198319c Dan Carpenter   2015-07-03  1878  		return -EINVAL;
e819cdb198319c Dan Carpenter   2015-07-03  1879  
^1da177e4c3f41 Linus Torvalds  2005-04-16  1880  	/* Verify that the final request frame will not be too large.
^1da177e4c3f41 Linus Torvalds  2005-04-16  1881  	 */
^1da177e4c3f41 Linus Torvalds  2005-04-16  1882  	sz = karg.dataSgeOffset * 4;
^1da177e4c3f41 Linus Torvalds  2005-04-16  1883  	if (karg.dataInSize > 0)
14d0f0b063f536 Kashyap, Desai  2009-05-29  1884  		sz += ioc->SGE_size;
^1da177e4c3f41 Linus Torvalds  2005-04-16  1885  	if (karg.dataOutSize > 0)
14d0f0b063f536 Kashyap, Desai  2009-05-29  1886  		sz += ioc->SGE_size;
^1da177e4c3f41 Linus Torvalds  2005-04-16  1887  
^1da177e4c3f41 Linus Torvalds  2005-04-16  1888  	if (sz > ioc->req_sz) {
29dd3609f2fc70 Eric Moore      2007-09-14  1889  		printk(MYIOC_s_ERR_FMT "%s@%d::mptctl_do_mpt_command - "
^1da177e4c3f41 Linus Torvalds  2005-04-16  1890  			"Request frame too large (%d) maximum (%d)\n",
29dd3609f2fc70 Eric Moore      2007-09-14  1891  			ioc->name, __FILE__, __LINE__, sz, ioc->req_sz);
^1da177e4c3f41 Linus Torvalds  2005-04-16  1892  		return -EFAULT;
^1da177e4c3f41 Linus Torvalds  2005-04-16  1893  	}
^1da177e4c3f41 Linus Torvalds  2005-04-16  1894  
^1da177e4c3f41 Linus Torvalds  2005-04-16  1895  	/* Get a free request frame and save the message context.
^1da177e4c3f41 Linus Torvalds  2005-04-16  1896  	 */
beda27821fd319 Mark Balantzyan 2019-08-14  1897  	mutex_lock(&mpctl_mutex);
^1da177e4c3f41 Linus Torvalds  2005-04-16  1898          if ((mf = mpt_get_msg_frame(mptctl_id, ioc)) == NULL)
beda27821fd319 Mark Balantzyan 2019-08-14  1899  	mutex_unlock(&mpctl_mutex);
^1da177e4c3f41 Linus Torvalds  2005-04-16  1900                  return -EAGAIN;
^1da177e4c3f41 Linus Torvalds  2005-04-16  1901  
^1da177e4c3f41 Linus Torvalds  2005-04-16  1902  	hdr = (MPIHeader_t *) mf;
^1da177e4c3f41 Linus Torvalds  2005-04-16  1903  	msgContext = le32_to_cpu(hdr->MsgContext);
^1da177e4c3f41 Linus Torvalds  2005-04-16  1904  	req_idx = le16_to_cpu(mf->u.frame.hwhdr.msgctxu.fld.req_idx);
^1da177e4c3f41 Linus Torvalds  2005-04-16  1905  
^1da177e4c3f41 Linus Torvalds  2005-04-16  1906  	/* Copy the request frame
^1da177e4c3f41 Linus Torvalds  2005-04-16  1907  	 * Reset the saved message context.
^1da177e4c3f41 Linus Torvalds  2005-04-16  1908  	 * Request frame in user space
^1da177e4c3f41 Linus Torvalds  2005-04-16  1909  	 */
^1da177e4c3f41 Linus Torvalds  2005-04-16  1910  	if (copy_from_user(mf, mfPtr, karg.dataSgeOffset * 4)) {
29dd3609f2fc70 Eric Moore      2007-09-14  1911  		printk(MYIOC_s_ERR_FMT "%s@%d::mptctl_do_mpt_command - "
^1da177e4c3f41 Linus Torvalds  2005-04-16  1912  			"Unable to read MF from mpt_ioctl_command struct @ %p\n",
29dd3609f2fc70 Eric Moore      2007-09-14  1913  			ioc->name, __FILE__, __LINE__, mfPtr);
ea2a788de4ce5e Kashyap, Desai  2009-05-29  1914  		function = -1;
^1da177e4c3f41 Linus Torvalds  2005-04-16  1915  		rc = -EFAULT;
^1da177e4c3f41 Linus Torvalds  2005-04-16  1916  		goto done_free_mem;
^1da177e4c3f41 Linus Torvalds  2005-04-16  1917  	}
^1da177e4c3f41 Linus Torvalds  2005-04-16  1918  	hdr->MsgContext = cpu_to_le32(msgContext);
ea2a788de4ce5e Kashyap, Desai  2009-05-29  1919  	function = hdr->Function;
^1da177e4c3f41 Linus Torvalds  2005-04-16  1920  
^1da177e4c3f41 Linus Torvalds  2005-04-16  1921  
^1da177e4c3f41 Linus Torvalds  2005-04-16  1922  	/* Verify that this request is allowed.
^1da177e4c3f41 Linus Torvalds  2005-04-16  1923  	 */
09120a8cd38dbd Prakash, Sathya 2007-07-24  1924  	dctlprintk(ioc, printk(MYIOC_s_DEBUG_FMT "sending mpi function (0x%02X), req=%p\n",
09120a8cd38dbd Prakash, Sathya 2007-07-24  1925  	    ioc->name, hdr->Function, mf));
09120a8cd38dbd Prakash, Sathya 2007-07-24  1926  
ea2a788de4ce5e Kashyap, Desai  2009-05-29  1927  	switch (function) {
^1da177e4c3f41 Linus Torvalds  2005-04-16  1928  	case MPI_FUNCTION_IOC_FACTS:
^1da177e4c3f41 Linus Torvalds  2005-04-16  1929  	case MPI_FUNCTION_PORT_FACTS:
^1da177e4c3f41 Linus Torvalds  2005-04-16  1930  		karg.dataOutSize  = karg.dataInSize = 0;
^1da177e4c3f41 Linus Torvalds  2005-04-16  1931  		break;
^1da177e4c3f41 Linus Torvalds  2005-04-16  1932  
^1da177e4c3f41 Linus Torvalds  2005-04-16  1933  	case MPI_FUNCTION_CONFIG:
09120a8cd38dbd Prakash, Sathya 2007-07-24  1934  	{
09120a8cd38dbd Prakash, Sathya 2007-07-24  1935  		Config_t *config_frame;
09120a8cd38dbd Prakash, Sathya 2007-07-24  1936  		config_frame = (Config_t *)mf;
09120a8cd38dbd Prakash, Sathya 2007-07-24  1937  		dctlprintk(ioc, printk(MYIOC_s_DEBUG_FMT "\ttype=0x%02x ext_type=0x%02x "
09120a8cd38dbd Prakash, Sathya 2007-07-24  1938  		    "number=0x%02x action=0x%02x\n", ioc->name,
09120a8cd38dbd Prakash, Sathya 2007-07-24  1939  		    config_frame->Header.PageType,
09120a8cd38dbd Prakash, Sathya 2007-07-24  1940  		    config_frame->ExtPageType,
09120a8cd38dbd Prakash, Sathya 2007-07-24  1941  		    config_frame->Header.PageNumber,
09120a8cd38dbd Prakash, Sathya 2007-07-24  1942  		    config_frame->Action));
09120a8cd38dbd Prakash, Sathya 2007-07-24  1943  		break;
09120a8cd38dbd Prakash, Sathya 2007-07-24  1944  	}
09120a8cd38dbd Prakash, Sathya 2007-07-24  1945  
^1da177e4c3f41 Linus Torvalds  2005-04-16  1946  	case MPI_FUNCTION_FC_COMMON_TRANSPORT_SEND:
^1da177e4c3f41 Linus Torvalds  2005-04-16  1947  	case MPI_FUNCTION_FC_EX_LINK_SRVC_SEND:
^1da177e4c3f41 Linus Torvalds  2005-04-16  1948  	case MPI_FUNCTION_FW_UPLOAD:
^1da177e4c3f41 Linus Torvalds  2005-04-16  1949  	case MPI_FUNCTION_SCSI_ENCLOSURE_PROCESSOR:
^1da177e4c3f41 Linus Torvalds  2005-04-16  1950  	case MPI_FUNCTION_FW_DOWNLOAD:
^1da177e4c3f41 Linus Torvalds  2005-04-16  1951  	case MPI_FUNCTION_FC_PRIMITIVE_SEND:
096f7a2a094af3 Moore, Eric     2006-02-02  1952  	case MPI_FUNCTION_TOOLBOX:
096f7a2a094af3 Moore, Eric     2006-02-02  1953  	case MPI_FUNCTION_SAS_IO_UNIT_CONTROL:
^1da177e4c3f41 Linus Torvalds  2005-04-16  1954  		break;
^1da177e4c3f41 Linus Torvalds  2005-04-16  1955  
^1da177e4c3f41 Linus Torvalds  2005-04-16  1956  	case MPI_FUNCTION_SCSI_IO_REQUEST:
^1da177e4c3f41 Linus Torvalds  2005-04-16  1957  		if (ioc->sh) {
^1da177e4c3f41 Linus Torvalds  2005-04-16  1958  			SCSIIORequest_t *pScsiReq = (SCSIIORequest_t *) mf;
^1da177e4c3f41 Linus Torvalds  2005-04-16  1959  			int qtag = MPI_SCSIIO_CONTROL_UNTAGGED;
^1da177e4c3f41 Linus Torvalds  2005-04-16  1960  			int scsidir = 0;
^1da177e4c3f41 Linus Torvalds  2005-04-16  1961  			int dataSize;
793955f549c710 Eric Moore      2007-01-29  1962  			u32 id;
^1da177e4c3f41 Linus Torvalds  2005-04-16  1963  
793955f549c710 Eric Moore      2007-01-29  1964  			id = (ioc->devices_per_bus == 0) ? 256 : ioc->devices_per_bus;
793955f549c710 Eric Moore      2007-01-29  1965  			if (pScsiReq->TargetID > id) {
29dd3609f2fc70 Eric Moore      2007-09-14  1966  				printk(MYIOC_s_ERR_FMT "%s@%d::mptctl_do_mpt_command - "
^1da177e4c3f41 Linus Torvalds  2005-04-16  1967  					"Target ID out of bounds. \n",
29dd3609f2fc70 Eric Moore      2007-09-14  1968  					ioc->name, __FILE__, __LINE__);
^1da177e4c3f41 Linus Torvalds  2005-04-16  1969  				rc = -ENODEV;
^1da177e4c3f41 Linus Torvalds  2005-04-16  1970  				goto done_free_mem;
^1da177e4c3f41 Linus Torvalds  2005-04-16  1971  			}
^1da177e4c3f41 Linus Torvalds  2005-04-16  1972  
793955f549c710 Eric Moore      2007-01-29  1973  			if (pScsiReq->Bus >= ioc->number_of_buses) {
29dd3609f2fc70 Eric Moore      2007-09-14  1974  				printk(MYIOC_s_ERR_FMT "%s@%d::mptctl_do_mpt_command - "
793955f549c710 Eric Moore      2007-01-29  1975  					"Target Bus out of bounds. \n",
29dd3609f2fc70 Eric Moore      2007-09-14  1976  					ioc->name, __FILE__, __LINE__);
793955f549c710 Eric Moore      2007-01-29  1977  				rc = -ENODEV;
793955f549c710 Eric Moore      2007-01-29  1978  				goto done_free_mem;
793955f549c710 Eric Moore      2007-01-29  1979  			}
793955f549c710 Eric Moore      2007-01-29  1980  
5f07e2499d6290 Moore, Eric     2006-02-02  1981  			pScsiReq->MsgFlags &= ~MPI_SCSIIO_MSGFLGS_SENSE_WIDTH;
14d0f0b063f536 Kashyap, Desai  2009-05-29  1982  			pScsiReq->MsgFlags |= mpt_msg_flags(ioc);
5f07e2499d6290 Moore, Eric     2006-02-02  1983  
^1da177e4c3f41 Linus Torvalds  2005-04-16  1984  
^1da177e4c3f41 Linus Torvalds  2005-04-16  1985  			/* verify that app has not requested
^1da177e4c3f41 Linus Torvalds  2005-04-16  1986  			 *	more sense data than driver
^1da177e4c3f41 Linus Torvalds  2005-04-16  1987  			 *	can provide, if so, reset this parameter
^1da177e4c3f41 Linus Torvalds  2005-04-16  1988  			 * set the sense buffer pointer low address
^1da177e4c3f41 Linus Torvalds  2005-04-16  1989  			 * update the control field to specify Q type
^1da177e4c3f41 Linus Torvalds  2005-04-16  1990  			 */
^1da177e4c3f41 Linus Torvalds  2005-04-16  1991  			if (karg.maxSenseBytes > MPT_SENSE_BUFFER_SIZE)
^1da177e4c3f41 Linus Torvalds  2005-04-16  1992  				pScsiReq->SenseBufferLength = MPT_SENSE_BUFFER_SIZE;
^1da177e4c3f41 Linus Torvalds  2005-04-16  1993  			else
^1da177e4c3f41 Linus Torvalds  2005-04-16  1994  				pScsiReq->SenseBufferLength = karg.maxSenseBytes;
^1da177e4c3f41 Linus Torvalds  2005-04-16  1995  
^1da177e4c3f41 Linus Torvalds  2005-04-16  1996  			pScsiReq->SenseBufferLowAddr =
^1da177e4c3f41 Linus Torvalds  2005-04-16  1997  				cpu_to_le32(ioc->sense_buf_low_dma
^1da177e4c3f41 Linus Torvalds  2005-04-16  1998  				   + (req_idx * MPT_SENSE_BUFFER_ALLOC));
^1da177e4c3f41 Linus Torvalds  2005-04-16  1999  
793955f549c710 Eric Moore      2007-01-29  2000  			shost_for_each_device(sdev, ioc->sh) {
793955f549c710 Eric Moore      2007-01-29  2001  				struct scsi_target *starget = scsi_target(sdev);
793955f549c710 Eric Moore      2007-01-29  2002  				VirtTarget *vtarget = starget->hostdata;
^1da177e4c3f41 Linus Torvalds  2005-04-16  2003  
08f5c5c23d52aa Kashyap, Desai  2010-03-18  2004  				if (vtarget == NULL)
08f5c5c23d52aa Kashyap, Desai  2010-03-18  2005  					continue;
08f5c5c23d52aa Kashyap, Desai  2010-03-18  2006  
793955f549c710 Eric Moore      2007-01-29  2007  				if ((pScsiReq->TargetID == vtarget->id) &&
793955f549c710 Eric Moore      2007-01-29  2008  				    (pScsiReq->Bus == vtarget->channel) &&
793955f549c710 Eric Moore      2007-01-29  2009  				    (vtarget->tflags & MPT_TARGET_FLAGS_Q_YES))
^1da177e4c3f41 Linus Torvalds  2005-04-16  2010  					qtag = MPI_SCSIIO_CONTROL_SIMPLEQ;
793955f549c710 Eric Moore      2007-01-29  2011  			}
^1da177e4c3f41 Linus Torvalds  2005-04-16  2012  
^1da177e4c3f41 Linus Torvalds  2005-04-16  2013  			/* Have the IOCTL driver set the direction based
^1da177e4c3f41 Linus Torvalds  2005-04-16  2014  			 * on the dataOutSize (ordering issue with Sparc).
^1da177e4c3f41 Linus Torvalds  2005-04-16  2015  			 */
^1da177e4c3f41 Linus Torvalds  2005-04-16  2016  			if (karg.dataOutSize > 0) {
^1da177e4c3f41 Linus Torvalds  2005-04-16  2017  				scsidir = MPI_SCSIIO_CONTROL_WRITE;
^1da177e4c3f41 Linus Torvalds  2005-04-16  2018  				dataSize = karg.dataOutSize;
^1da177e4c3f41 Linus Torvalds  2005-04-16  2019  			} else {
^1da177e4c3f41 Linus Torvalds  2005-04-16  2020  				scsidir = MPI_SCSIIO_CONTROL_READ;
^1da177e4c3f41 Linus Torvalds  2005-04-16  2021  				dataSize = karg.dataInSize;
^1da177e4c3f41 Linus Torvalds  2005-04-16  2022  			}
^1da177e4c3f41 Linus Torvalds  2005-04-16  2023  
^1da177e4c3f41 Linus Torvalds  2005-04-16  2024  			pScsiReq->Control = cpu_to_le32(scsidir | qtag);
^1da177e4c3f41 Linus Torvalds  2005-04-16  2025  			pScsiReq->DataLength = cpu_to_le32(dataSize);
^1da177e4c3f41 Linus Torvalds  2005-04-16  2026  
^1da177e4c3f41 Linus Torvalds  2005-04-16  2027  
^1da177e4c3f41 Linus Torvalds  2005-04-16  2028  		} else {
29dd3609f2fc70 Eric Moore      2007-09-14  2029  			printk(MYIOC_s_ERR_FMT "%s@%d::mptctl_do_mpt_command - "
^1da177e4c3f41 Linus Torvalds  2005-04-16  2030  				"SCSI driver is not loaded. \n",
29dd3609f2fc70 Eric Moore      2007-09-14  2031  				ioc->name, __FILE__, __LINE__);
^1da177e4c3f41 Linus Torvalds  2005-04-16  2032  			rc = -EFAULT;
^1da177e4c3f41 Linus Torvalds  2005-04-16  2033  			goto done_free_mem;
^1da177e4c3f41 Linus Torvalds  2005-04-16  2034  		}
^1da177e4c3f41 Linus Torvalds  2005-04-16  2035  		break;
^1da177e4c3f41 Linus Torvalds  2005-04-16  2036  
096f7a2a094af3 Moore, Eric     2006-02-02  2037  	case MPI_FUNCTION_SMP_PASSTHROUGH:
096f7a2a094af3 Moore, Eric     2006-02-02  2038  		/* Check mf->PassthruFlags to determine if
096f7a2a094af3 Moore, Eric     2006-02-02  2039  		 * transfer is ImmediateMode or not.
096f7a2a094af3 Moore, Eric     2006-02-02  2040  		 * Immediate mode returns data in the ReplyFrame.
096f7a2a094af3 Moore, Eric     2006-02-02  2041  		 * Else, we are sending request and response data
096f7a2a094af3 Moore, Eric     2006-02-02  2042  		 * in two SGLs at the end of the mf.
096f7a2a094af3 Moore, Eric     2006-02-02  2043  		 */
096f7a2a094af3 Moore, Eric     2006-02-02  2044  		break;
096f7a2a094af3 Moore, Eric     2006-02-02  2045  
096f7a2a094af3 Moore, Eric     2006-02-02  2046  	case MPI_FUNCTION_SATA_PASSTHROUGH:
096f7a2a094af3 Moore, Eric     2006-02-02  2047  		if (!ioc->sh) {
29dd3609f2fc70 Eric Moore      2007-09-14  2048  			printk(MYIOC_s_ERR_FMT "%s@%d::mptctl_do_mpt_command - "
096f7a2a094af3 Moore, Eric     2006-02-02  2049  				"SCSI driver is not loaded. \n",
29dd3609f2fc70 Eric Moore      2007-09-14  2050  				ioc->name, __FILE__, __LINE__);
096f7a2a094af3 Moore, Eric     2006-02-02  2051  			rc = -EFAULT;
096f7a2a094af3 Moore, Eric     2006-02-02  2052  			goto done_free_mem;
096f7a2a094af3 Moore, Eric     2006-02-02  2053  		}
096f7a2a094af3 Moore, Eric     2006-02-02  2054  		break;
096f7a2a094af3 Moore, Eric     2006-02-02  2055  
^1da177e4c3f41 Linus Torvalds  2005-04-16  2056  	case MPI_FUNCTION_RAID_ACTION:
^1da177e4c3f41 Linus Torvalds  2005-04-16  2057  		/* Just add a SGE
^1da177e4c3f41 Linus Torvalds  2005-04-16  2058  		 */
^1da177e4c3f41 Linus Torvalds  2005-04-16  2059  		break;
^1da177e4c3f41 Linus Torvalds  2005-04-16  2060  
^1da177e4c3f41 Linus Torvalds  2005-04-16  2061  	case MPI_FUNCTION_RAID_SCSI_IO_PASSTHROUGH:
^1da177e4c3f41 Linus Torvalds  2005-04-16  2062  		if (ioc->sh) {
^1da177e4c3f41 Linus Torvalds  2005-04-16  2063  			SCSIIORequest_t *pScsiReq = (SCSIIORequest_t *) mf;
^1da177e4c3f41 Linus Torvalds  2005-04-16  2064  			int qtag = MPI_SCSIIO_CONTROL_SIMPLEQ;
^1da177e4c3f41 Linus Torvalds  2005-04-16  2065  			int scsidir = MPI_SCSIIO_CONTROL_READ;
^1da177e4c3f41 Linus Torvalds  2005-04-16  2066  			int dataSize;
^1da177e4c3f41 Linus Torvalds  2005-04-16  2067  
5f07e2499d6290 Moore, Eric     2006-02-02  2068  			pScsiReq->MsgFlags &= ~MPI_SCSIIO_MSGFLGS_SENSE_WIDTH;
14d0f0b063f536 Kashyap, Desai  2009-05-29  2069  			pScsiReq->MsgFlags |= mpt_msg_flags(ioc);
5f07e2499d6290 Moore, Eric     2006-02-02  2070  
^1da177e4c3f41 Linus Torvalds  2005-04-16  2071  
^1da177e4c3f41 Linus Torvalds  2005-04-16  2072  			/* verify that app has not requested
^1da177e4c3f41 Linus Torvalds  2005-04-16  2073  			 *	more sense data than driver
^1da177e4c3f41 Linus Torvalds  2005-04-16  2074  			 *	can provide, if so, reset this parameter
^1da177e4c3f41 Linus Torvalds  2005-04-16  2075  			 * set the sense buffer pointer low address
^1da177e4c3f41 Linus Torvalds  2005-04-16  2076  			 * update the control field to specify Q type
^1da177e4c3f41 Linus Torvalds  2005-04-16  2077  			 */
^1da177e4c3f41 Linus Torvalds  2005-04-16  2078  			if (karg.maxSenseBytes > MPT_SENSE_BUFFER_SIZE)
^1da177e4c3f41 Linus Torvalds  2005-04-16  2079  				pScsiReq->SenseBufferLength = MPT_SENSE_BUFFER_SIZE;
^1da177e4c3f41 Linus Torvalds  2005-04-16  2080  			else
^1da177e4c3f41 Linus Torvalds  2005-04-16  2081  				pScsiReq->SenseBufferLength = karg.maxSenseBytes;
^1da177e4c3f41 Linus Torvalds  2005-04-16  2082  
^1da177e4c3f41 Linus Torvalds  2005-04-16  2083  			pScsiReq->SenseBufferLowAddr =
^1da177e4c3f41 Linus Torvalds  2005-04-16  2084  				cpu_to_le32(ioc->sense_buf_low_dma
^1da177e4c3f41 Linus Torvalds  2005-04-16  2085  				   + (req_idx * MPT_SENSE_BUFFER_ALLOC));
^1da177e4c3f41 Linus Torvalds  2005-04-16  2086  
^1da177e4c3f41 Linus Torvalds  2005-04-16  2087  			/* All commands to physical devices are tagged
^1da177e4c3f41 Linus Torvalds  2005-04-16  2088  			 */
^1da177e4c3f41 Linus Torvalds  2005-04-16  2089  
^1da177e4c3f41 Linus Torvalds  2005-04-16  2090  			/* Have the IOCTL driver set the direction based
^1da177e4c3f41 Linus Torvalds  2005-04-16  2091  			 * on the dataOutSize (ordering issue with Sparc).
^1da177e4c3f41 Linus Torvalds  2005-04-16  2092  			 */
^1da177e4c3f41 Linus Torvalds  2005-04-16  2093  			if (karg.dataOutSize > 0) {
^1da177e4c3f41 Linus Torvalds  2005-04-16  2094  				scsidir = MPI_SCSIIO_CONTROL_WRITE;
^1da177e4c3f41 Linus Torvalds  2005-04-16  2095  				dataSize = karg.dataOutSize;
^1da177e4c3f41 Linus Torvalds  2005-04-16  2096  			} else {
^1da177e4c3f41 Linus Torvalds  2005-04-16  2097  				scsidir = MPI_SCSIIO_CONTROL_READ;
^1da177e4c3f41 Linus Torvalds  2005-04-16  2098  				dataSize = karg.dataInSize;
^1da177e4c3f41 Linus Torvalds  2005-04-16  2099  			}
^1da177e4c3f41 Linus Torvalds  2005-04-16  2100  
^1da177e4c3f41 Linus Torvalds  2005-04-16  2101  			pScsiReq->Control = cpu_to_le32(scsidir | qtag);
^1da177e4c3f41 Linus Torvalds  2005-04-16  2102  			pScsiReq->DataLength = cpu_to_le32(dataSize);
^1da177e4c3f41 Linus Torvalds  2005-04-16  2103  
^1da177e4c3f41 Linus Torvalds  2005-04-16  2104  		} else {
29dd3609f2fc70 Eric Moore      2007-09-14  2105  			printk(MYIOC_s_ERR_FMT "%s@%d::mptctl_do_mpt_command - "
^1da177e4c3f41 Linus Torvalds  2005-04-16  2106  				"SCSI driver is not loaded. \n",
29dd3609f2fc70 Eric Moore      2007-09-14  2107  				ioc->name, __FILE__, __LINE__);
^1da177e4c3f41 Linus Torvalds  2005-04-16  2108  			rc = -EFAULT;
^1da177e4c3f41 Linus Torvalds  2005-04-16  2109  			goto done_free_mem;
^1da177e4c3f41 Linus Torvalds  2005-04-16  2110  		}
^1da177e4c3f41 Linus Torvalds  2005-04-16  2111  		break;
^1da177e4c3f41 Linus Torvalds  2005-04-16  2112  
^1da177e4c3f41 Linus Torvalds  2005-04-16  2113  	case MPI_FUNCTION_SCSI_TASK_MGMT:
^1da177e4c3f41 Linus Torvalds  2005-04-16  2114  	{
ea2a788de4ce5e Kashyap, Desai  2009-05-29  2115  		SCSITaskMgmt_t	*pScsiTm;
ea2a788de4ce5e Kashyap, Desai  2009-05-29  2116  		pScsiTm = (SCSITaskMgmt_t *)mf;
ea2a788de4ce5e Kashyap, Desai  2009-05-29  2117  		dctlprintk(ioc, printk(MYIOC_s_DEBUG_FMT
ea2a788de4ce5e Kashyap, Desai  2009-05-29  2118  			"\tTaskType=0x%x MsgFlags=0x%x "
ea2a788de4ce5e Kashyap, Desai  2009-05-29  2119  			"TaskMsgContext=0x%x id=%d channel=%d\n",
ea2a788de4ce5e Kashyap, Desai  2009-05-29  2120  			ioc->name, pScsiTm->TaskType, le32_to_cpu
ea2a788de4ce5e Kashyap, Desai  2009-05-29  2121  			(pScsiTm->TaskMsgContext), pScsiTm->MsgFlags,
ea2a788de4ce5e Kashyap, Desai  2009-05-29  2122  			pScsiTm->TargetID, pScsiTm->Bus));
^1da177e4c3f41 Linus Torvalds  2005-04-16  2123  		break;
ea2a788de4ce5e Kashyap, Desai  2009-05-29  2124  	}
^1da177e4c3f41 Linus Torvalds  2005-04-16  2125  
^1da177e4c3f41 Linus Torvalds  2005-04-16  2126  	case MPI_FUNCTION_IOC_INIT:
^1da177e4c3f41 Linus Torvalds  2005-04-16  2127  		{
^1da177e4c3f41 Linus Torvalds  2005-04-16  2128  			IOCInit_t	*pInit = (IOCInit_t *) mf;
^1da177e4c3f41 Linus Torvalds  2005-04-16  2129  			u32		high_addr, sense_high;
^1da177e4c3f41 Linus Torvalds  2005-04-16  2130  
^1da177e4c3f41 Linus Torvalds  2005-04-16  2131  			/* Verify that all entries in the IOC INIT match
^1da177e4c3f41 Linus Torvalds  2005-04-16  2132  			 * existing setup (and in LE format).
^1da177e4c3f41 Linus Torvalds  2005-04-16  2133  			 */
^1da177e4c3f41 Linus Torvalds  2005-04-16  2134  			if (sizeof(dma_addr_t) == sizeof(u64)) {
^1da177e4c3f41 Linus Torvalds  2005-04-16  2135  				high_addr = cpu_to_le32((u32)((u64)ioc->req_frames_dma >> 32));
^1da177e4c3f41 Linus Torvalds  2005-04-16  2136  				sense_high= cpu_to_le32((u32)((u64)ioc->sense_buf_pool_dma >> 32));
^1da177e4c3f41 Linus Torvalds  2005-04-16  2137  			} else {
^1da177e4c3f41 Linus Torvalds  2005-04-16  2138  				high_addr = 0;
^1da177e4c3f41 Linus Torvalds  2005-04-16  2139  				sense_high= 0;
^1da177e4c3f41 Linus Torvalds  2005-04-16  2140  			}
^1da177e4c3f41 Linus Torvalds  2005-04-16  2141  
^1da177e4c3f41 Linus Torvalds  2005-04-16  2142  			if ((pInit->Flags != 0) || (pInit->MaxDevices != ioc->facts.MaxDevices) ||
^1da177e4c3f41 Linus Torvalds  2005-04-16  2143  				(pInit->MaxBuses != ioc->facts.MaxBuses) ||
^1da177e4c3f41 Linus Torvalds  2005-04-16  2144  				(pInit->ReplyFrameSize != cpu_to_le16(ioc->reply_sz)) ||
^1da177e4c3f41 Linus Torvalds  2005-04-16  2145  				(pInit->HostMfaHighAddr != high_addr) ||
^1da177e4c3f41 Linus Torvalds  2005-04-16  2146  				(pInit->SenseBufferHighAddr != sense_high)) {
29dd3609f2fc70 Eric Moore      2007-09-14  2147  				printk(MYIOC_s_ERR_FMT "%s@%d::mptctl_do_mpt_command - "
^1da177e4c3f41 Linus Torvalds  2005-04-16  2148  					"IOC_INIT issued with 1 or more incorrect parameters. Rejected.\n",
29dd3609f2fc70 Eric Moore      2007-09-14  2149  					ioc->name, __FILE__, __LINE__);
^1da177e4c3f41 Linus Torvalds  2005-04-16  2150  				rc = -EFAULT;
^1da177e4c3f41 Linus Torvalds  2005-04-16  2151  				goto done_free_mem;
^1da177e4c3f41 Linus Torvalds  2005-04-16  2152  			}
^1da177e4c3f41 Linus Torvalds  2005-04-16  2153  		}
^1da177e4c3f41 Linus Torvalds  2005-04-16  2154  		break;
^1da177e4c3f41 Linus Torvalds  2005-04-16  2155  	default:
^1da177e4c3f41 Linus Torvalds  2005-04-16  2156  		/*
^1da177e4c3f41 Linus Torvalds  2005-04-16  2157  		 * MPI_FUNCTION_PORT_ENABLE
^1da177e4c3f41 Linus Torvalds  2005-04-16  2158  		 * MPI_FUNCTION_TARGET_CMD_BUFFER_POST
^1da177e4c3f41 Linus Torvalds  2005-04-16  2159  		 * MPI_FUNCTION_TARGET_ASSIST
^1da177e4c3f41 Linus Torvalds  2005-04-16  2160  		 * MPI_FUNCTION_TARGET_STATUS_SEND
^1da177e4c3f41 Linus Torvalds  2005-04-16  2161  		 * MPI_FUNCTION_TARGET_MODE_ABORT
^1da177e4c3f41 Linus Torvalds  2005-04-16  2162  		 * MPI_FUNCTION_IOC_MESSAGE_UNIT_RESET
^1da177e4c3f41 Linus Torvalds  2005-04-16  2163  		 * MPI_FUNCTION_IO_UNIT_RESET
^1da177e4c3f41 Linus Torvalds  2005-04-16  2164  		 * MPI_FUNCTION_HANDSHAKE
^1da177e4c3f41 Linus Torvalds  2005-04-16  2165  		 * MPI_FUNCTION_REPLY_FRAME_REMOVAL
^1da177e4c3f41 Linus Torvalds  2005-04-16  2166  		 * MPI_FUNCTION_EVENT_NOTIFICATION
^1da177e4c3f41 Linus Torvalds  2005-04-16  2167  		 *  (driver handles event notification)
^1da177e4c3f41 Linus Torvalds  2005-04-16  2168  		 * MPI_FUNCTION_EVENT_ACK
^1da177e4c3f41 Linus Torvalds  2005-04-16  2169  		 */
^1da177e4c3f41 Linus Torvalds  2005-04-16  2170  
^1da177e4c3f41 Linus Torvalds  2005-04-16  2171  		/*  What to do with these???  CHECK ME!!!
^1da177e4c3f41 Linus Torvalds  2005-04-16  2172  			MPI_FUNCTION_FC_LINK_SRVC_BUF_POST
^1da177e4c3f41 Linus Torvalds  2005-04-16  2173  			MPI_FUNCTION_FC_LINK_SRVC_RSP
^1da177e4c3f41 Linus Torvalds  2005-04-16  2174  			MPI_FUNCTION_FC_ABORT
^1da177e4c3f41 Linus Torvalds  2005-04-16  2175  			MPI_FUNCTION_LAN_SEND
^1da177e4c3f41 Linus Torvalds  2005-04-16  2176  			MPI_FUNCTION_LAN_RECEIVE
^1da177e4c3f41 Linus Torvalds  2005-04-16  2177  		 	MPI_FUNCTION_LAN_RESET
^1da177e4c3f41 Linus Torvalds  2005-04-16  2178  		*/
^1da177e4c3f41 Linus Torvalds  2005-04-16  2179  
29dd3609f2fc70 Eric Moore      2007-09-14  2180  		printk(MYIOC_s_ERR_FMT "%s@%d::mptctl_do_mpt_command - "
^1da177e4c3f41 Linus Torvalds  2005-04-16  2181  			"Illegal request (function 0x%x) \n",
29dd3609f2fc70 Eric Moore      2007-09-14  2182  			ioc->name, __FILE__, __LINE__, hdr->Function);
^1da177e4c3f41 Linus Torvalds  2005-04-16  2183  		rc = -EFAULT;
^1da177e4c3f41 Linus Torvalds  2005-04-16  2184  		goto done_free_mem;
^1da177e4c3f41 Linus Torvalds  2005-04-16  2185  	}
^1da177e4c3f41 Linus Torvalds  2005-04-16  2186  
^1da177e4c3f41 Linus Torvalds  2005-04-16  2187  	/* Add the SGL ( at most one data in SGE and one data out SGE )
^1da177e4c3f41 Linus Torvalds  2005-04-16  2188  	 * In the case of two SGE's - the data out (write) will always
^1da177e4c3f41 Linus Torvalds  2005-04-16  2189  	 * preceede the data in (read) SGE. psgList is used to free the
^1da177e4c3f41 Linus Torvalds  2005-04-16  2190  	 * allocated memory.
^1da177e4c3f41 Linus Torvalds  2005-04-16  2191  	 */
^1da177e4c3f41 Linus Torvalds  2005-04-16  2192  	psge = (char *) (((int *) mf) + karg.dataSgeOffset);
^1da177e4c3f41 Linus Torvalds  2005-04-16  2193  	flagsLength = 0;
^1da177e4c3f41 Linus Torvalds  2005-04-16  2194  
^1da177e4c3f41 Linus Torvalds  2005-04-16  2195  	if (karg.dataOutSize > 0)
^1da177e4c3f41 Linus Torvalds  2005-04-16  2196  		sgSize ++;
^1da177e4c3f41 Linus Torvalds  2005-04-16  2197  
^1da177e4c3f41 Linus Torvalds  2005-04-16  2198  	if (karg.dataInSize > 0)
^1da177e4c3f41 Linus Torvalds  2005-04-16  2199  		sgSize ++;
^1da177e4c3f41 Linus Torvalds  2005-04-16  2200  
^1da177e4c3f41 Linus Torvalds  2005-04-16  2201  	if (sgSize > 0) {
^1da177e4c3f41 Linus Torvalds  2005-04-16  2202  
^1da177e4c3f41 Linus Torvalds  2005-04-16  2203  		/* Set up the dataOut memory allocation */
^1da177e4c3f41 Linus Torvalds  2005-04-16  2204  		if (karg.dataOutSize > 0) {
^1da177e4c3f41 Linus Torvalds  2005-04-16  2205  			if (karg.dataInSize > 0) {
^1da177e4c3f41 Linus Torvalds  2005-04-16  2206  				flagsLength = ( MPI_SGE_FLAGS_SIMPLE_ELEMENT |
^1da177e4c3f41 Linus Torvalds  2005-04-16  2207  						MPI_SGE_FLAGS_END_OF_BUFFER |
14d0f0b063f536 Kashyap, Desai  2009-05-29  2208  						MPI_SGE_FLAGS_DIRECTION)
^1da177e4c3f41 Linus Torvalds  2005-04-16  2209  						<< MPI_SGE_FLAGS_SHIFT;
^1da177e4c3f41 Linus Torvalds  2005-04-16  2210  			} else {
^1da177e4c3f41 Linus Torvalds  2005-04-16  2211  				flagsLength = MPT_SGE_FLAGS_SSIMPLE_WRITE;
^1da177e4c3f41 Linus Torvalds  2005-04-16  2212  			}
^1da177e4c3f41 Linus Torvalds  2005-04-16  2213  			flagsLength |= karg.dataOutSize;
^1da177e4c3f41 Linus Torvalds  2005-04-16  2214  			bufOut.len = karg.dataOutSize;
^1da177e4c3f41 Linus Torvalds  2005-04-16  2215  			bufOut.kptr = pci_alloc_consistent(
^1da177e4c3f41 Linus Torvalds  2005-04-16  2216  					ioc->pcidev, bufOut.len, &dma_addr_out);
^1da177e4c3f41 Linus Torvalds  2005-04-16  2217  
^1da177e4c3f41 Linus Torvalds  2005-04-16  2218  			if (bufOut.kptr == NULL) {
^1da177e4c3f41 Linus Torvalds  2005-04-16  2219  				rc = -ENOMEM;
^1da177e4c3f41 Linus Torvalds  2005-04-16  2220  				goto done_free_mem;
^1da177e4c3f41 Linus Torvalds  2005-04-16  2221  			} else {
^1da177e4c3f41 Linus Torvalds  2005-04-16  2222  				/* Set up this SGE.
^1da177e4c3f41 Linus Torvalds  2005-04-16  2223  				 * Copy to MF and to sglbuf
^1da177e4c3f41 Linus Torvalds  2005-04-16  2224  				 */
14d0f0b063f536 Kashyap, Desai  2009-05-29  2225  				ioc->add_sge(psge, flagsLength, dma_addr_out);
14d0f0b063f536 Kashyap, Desai  2009-05-29  2226  				psge += ioc->SGE_size;
^1da177e4c3f41 Linus Torvalds  2005-04-16  2227  
^1da177e4c3f41 Linus Torvalds  2005-04-16  2228  				/* Copy user data to kernel space.
^1da177e4c3f41 Linus Torvalds  2005-04-16  2229  				 */
^1da177e4c3f41 Linus Torvalds  2005-04-16  2230  				if (copy_from_user(bufOut.kptr,
^1da177e4c3f41 Linus Torvalds  2005-04-16  2231  						karg.dataOutBufPtr,
^1da177e4c3f41 Linus Torvalds  2005-04-16  2232  						bufOut.len)) {
29dd3609f2fc70 Eric Moore      2007-09-14  2233  					printk(MYIOC_s_ERR_FMT
^1da177e4c3f41 Linus Torvalds  2005-04-16  2234  						"%s@%d::mptctl_do_mpt_command - Unable "
^1da177e4c3f41 Linus Torvalds  2005-04-16  2235  						"to read user data "
^1da177e4c3f41 Linus Torvalds  2005-04-16  2236  						"struct @ %p\n",
29dd3609f2fc70 Eric Moore      2007-09-14  2237  						ioc->name, __FILE__, __LINE__,karg.dataOutBufPtr);
^1da177e4c3f41 Linus Torvalds  2005-04-16  2238  					rc =  -EFAULT;
^1da177e4c3f41 Linus Torvalds  2005-04-16  2239  					goto done_free_mem;
^1da177e4c3f41 Linus Torvalds  2005-04-16  2240  				}
^1da177e4c3f41 Linus Torvalds  2005-04-16  2241  			}
^1da177e4c3f41 Linus Torvalds  2005-04-16  2242  		}
^1da177e4c3f41 Linus Torvalds  2005-04-16  2243  
^1da177e4c3f41 Linus Torvalds  2005-04-16  2244  		if (karg.dataInSize > 0) {
^1da177e4c3f41 Linus Torvalds  2005-04-16  2245  			flagsLength = MPT_SGE_FLAGS_SSIMPLE_READ;
^1da177e4c3f41 Linus Torvalds  2005-04-16  2246  			flagsLength |= karg.dataInSize;
^1da177e4c3f41 Linus Torvalds  2005-04-16  2247  
^1da177e4c3f41 Linus Torvalds  2005-04-16  2248  			bufIn.len = karg.dataInSize;
^1da177e4c3f41 Linus Torvalds  2005-04-16  2249  			bufIn.kptr = pci_alloc_consistent(ioc->pcidev,
^1da177e4c3f41 Linus Torvalds  2005-04-16  2250  					bufIn.len, &dma_addr_in);
^1da177e4c3f41 Linus Torvalds  2005-04-16  2251  
^1da177e4c3f41 Linus Torvalds  2005-04-16  2252  			if (bufIn.kptr == NULL) {
^1da177e4c3f41 Linus Torvalds  2005-04-16  2253  				rc = -ENOMEM;
^1da177e4c3f41 Linus Torvalds  2005-04-16  2254  				goto done_free_mem;
^1da177e4c3f41 Linus Torvalds  2005-04-16  2255  			} else {
^1da177e4c3f41 Linus Torvalds  2005-04-16  2256  				/* Set up this SGE
^1da177e4c3f41 Linus Torvalds  2005-04-16  2257  				 * Copy to MF and to sglbuf
^1da177e4c3f41 Linus Torvalds  2005-04-16  2258  				 */
14d0f0b063f536 Kashyap, Desai  2009-05-29  2259  				ioc->add_sge(psge, flagsLength, dma_addr_in);
^1da177e4c3f41 Linus Torvalds  2005-04-16  2260  			}
^1da177e4c3f41 Linus Torvalds  2005-04-16  2261  		}
^1da177e4c3f41 Linus Torvalds  2005-04-16  2262  	} else  {
^1da177e4c3f41 Linus Torvalds  2005-04-16  2263  		/* Add a NULL SGE
^1da177e4c3f41 Linus Torvalds  2005-04-16  2264  		 */
14d0f0b063f536 Kashyap, Desai  2009-05-29  2265  		ioc->add_sge(psge, flagsLength, (dma_addr_t) -1);
^1da177e4c3f41 Linus Torvalds  2005-04-16  2266  	}
^1da177e4c3f41 Linus Torvalds  2005-04-16  2267  
ea2a788de4ce5e Kashyap, Desai  2009-05-29  2268  	SET_MGMT_MSG_CONTEXT(ioc->ioctl_cmds.msg_context, hdr->MsgContext);
ea2a788de4ce5e Kashyap, Desai  2009-05-29  2269  	INITIALIZE_MGMT_STATUS(ioc->ioctl_cmds.status)
^1da177e4c3f41 Linus Torvalds  2005-04-16  2270  	if (hdr->Function == MPI_FUNCTION_SCSI_TASK_MGMT) {
^1da177e4c3f41 Linus Torvalds  2005-04-16  2271  
ea2a788de4ce5e Kashyap, Desai  2009-05-29  2272  		mutex_lock(&ioc->taskmgmt_cmds.mutex);
ea2a788de4ce5e Kashyap, Desai  2009-05-29  2273  		if (mpt_set_taskmgmt_in_progress_flag(ioc) != 0) {
ea2a788de4ce5e Kashyap, Desai  2009-05-29  2274  			mutex_unlock(&ioc->taskmgmt_cmds.mutex);
ea2a788de4ce5e Kashyap, Desai  2009-05-29  2275  			goto done_free_mem;
ea2a788de4ce5e Kashyap, Desai  2009-05-29  2276  		}
ea2a788de4ce5e Kashyap, Desai  2009-05-29  2277  
09120a8cd38dbd Prakash, Sathya 2007-07-24  2278  		DBG_DUMP_TM_REQUEST_FRAME(ioc, (u32 *)mf);
^1da177e4c3f41 Linus Torvalds  2005-04-16  2279  
7a195f464e0692 Prakash, Sathya 2007-08-14  2280  		if ((ioc->facts.IOCCapabilities & MPI_IOCFACTS_CAPABILITY_HIGH_PRI_Q) &&
beda27821fd319 Mark Balantzyan 2019-08-14  2281  		    (ioc->facts.MsgVersion >= MPI_VERSION_01_05)) {
beda27821fd319 Mark Balantzyan 2019-08-14  2282  			mutex_lock(&mpctl_mutex);
7a195f464e0692 Prakash, Sathya 2007-08-14  2283  			mpt_put_msg_frame_hi_pri(mptctl_id, ioc, mf);
beda27821fd319 Mark Balantzyan 2019-08-14  2284  			mutex_unlock(&mpctl_mutex);
beda27821fd319 Mark Balantzyan 2019-08-14  2285  		} else {
beda27821fd319 Mark Balantzyan 2019-08-14  2286  			mutex_lock(&mpctl_mutex);
beda27821fd319 Mark Balantzyan 2019-08-14  2287  			rc = mpt_send_handshake_request(mptctl_id, ioc, sizeof(SCSITaskMgmt_t), (u32 *)mf, CAN_SLEEP);
beda27821fd319 Mark Balantzyan 2019-08-14  2288  			mutex_unlock(&mpctl_mutex);
7a195f464e0692 Prakash, Sathya 2007-08-14  2289  			if (rc != 0) {
7a195f464e0692 Prakash, Sathya 2007-08-14  2290  				dfailprintk(ioc, printk(MYIOC_s_ERR_FMT
ea2a788de4ce5e Kashyap, Desai  2009-05-29  2291  				    "send_handshake FAILED! (ioc %p, mf %p)\n",
7a195f464e0692 Prakash, Sathya 2007-08-14  2292  				    ioc->name, ioc, mf));
ea2a788de4ce5e Kashyap, Desai  2009-05-29  2293  				mpt_clear_taskmgmt_in_progress_flag(ioc);
^1da177e4c3f41 Linus Torvalds  2005-04-16  2294  				rc = -ENODATA;
ea2a788de4ce5e Kashyap, Desai  2009-05-29  2295  				mutex_unlock(&ioc->taskmgmt_cmds.mutex);
^1da177e4c3f41 Linus Torvalds  2005-04-16  2296  				goto done_free_mem;
^1da177e4c3f41 Linus Torvalds  2005-04-16  2297  			}
7a195f464e0692 Prakash, Sathya 2007-08-14  2298  		}
^1da177e4c3f41 Linus Torvalds  2005-04-16  2299  
^1da177e4c3f41 Linus Torvalds  2005-04-16 @2300  	} else
beda27821fd319 Mark Balantzyan 2019-08-14  2301  		mutex_lock(&mpctl_mutex);
^1da177e4c3f41 Linus Torvalds  2005-04-16  2302  		mpt_put_msg_frame(mptctl_id, ioc, mf);
beda27821fd319 Mark Balantzyan 2019-08-14  2303  		mutex_unlock(&mpctl_mutex);
^1da177e4c3f41 Linus Torvalds  2005-04-16  2304  
^1da177e4c3f41 Linus Torvalds  2005-04-16  2305  	/* Now wait for the command to complete */
^1da177e4c3f41 Linus Torvalds  2005-04-16  2306  	timeout = (karg.timeout > 0) ? karg.timeout : MPT_IOCTL_DEFAULT_TIMEOUT;
ea2a788de4ce5e Kashyap, Desai  2009-05-29  2307  retry_wait:
ea2a788de4ce5e Kashyap, Desai  2009-05-29  2308  	timeleft = wait_for_completion_timeout(&ioc->ioctl_cmds.done,
^1da177e4c3f41 Linus Torvalds  2005-04-16  2309  				HZ*timeout);
ea2a788de4ce5e Kashyap, Desai  2009-05-29  2310  	if (!(ioc->ioctl_cmds.status & MPT_MGMT_STATUS_COMMAND_GOOD)) {
ea2a788de4ce5e Kashyap, Desai  2009-05-29  2311  		rc = -ETIME;
ea2a788de4ce5e Kashyap, Desai  2009-05-29  2312  		dfailprintk(ioc, printk(MYIOC_s_ERR_FMT "%s: TIMED OUT!\n",
ea2a788de4ce5e Kashyap, Desai  2009-05-29  2313  		    ioc->name, __func__));
ea2a788de4ce5e Kashyap, Desai  2009-05-29  2314  		if (ioc->ioctl_cmds.status & MPT_MGMT_STATUS_DID_IOCRESET) {
ea2a788de4ce5e Kashyap, Desai  2009-05-29  2315  			if (function == MPI_FUNCTION_SCSI_TASK_MGMT)
ea2a788de4ce5e Kashyap, Desai  2009-05-29  2316  				mutex_unlock(&ioc->taskmgmt_cmds.mutex);
^1da177e4c3f41 Linus Torvalds  2005-04-16  2317  			goto done_free_mem;
^1da177e4c3f41 Linus Torvalds  2005-04-16  2318  		}
ea2a788de4ce5e Kashyap, Desai  2009-05-29  2319  		if (!timeleft) {
97009a29e8c999 Kei Tokunaga    2010-06-22  2320  			printk(MYIOC_s_WARN_FMT
97009a29e8c999 Kei Tokunaga    2010-06-22  2321  			       "mpt cmd timeout, doorbell=0x%08x"
97009a29e8c999 Kei Tokunaga    2010-06-22  2322  			       " function=0x%x\n",
97009a29e8c999 Kei Tokunaga    2010-06-22  2323  			       ioc->name, mpt_GetIocState(ioc, 0), function);
ea2a788de4ce5e Kashyap, Desai  2009-05-29  2324  			if (function == MPI_FUNCTION_SCSI_TASK_MGMT)
ea2a788de4ce5e Kashyap, Desai  2009-05-29  2325  				mutex_unlock(&ioc->taskmgmt_cmds.mutex);
ea2a788de4ce5e Kashyap, Desai  2009-05-29  2326  			mptctl_timeout_expired(ioc, mf);
ea2a788de4ce5e Kashyap, Desai  2009-05-29  2327  			mf = NULL;
ea2a788de4ce5e Kashyap, Desai  2009-05-29  2328  		} else
ea2a788de4ce5e Kashyap, Desai  2009-05-29  2329  			goto retry_wait;
ea2a788de4ce5e Kashyap, Desai  2009-05-29  2330  		goto done_free_mem;
ea2a788de4ce5e Kashyap, Desai  2009-05-29  2331  	}
ea2a788de4ce5e Kashyap, Desai  2009-05-29  2332  
ea2a788de4ce5e Kashyap, Desai  2009-05-29  2333  	if (function == MPI_FUNCTION_SCSI_TASK_MGMT)
ea2a788de4ce5e Kashyap, Desai  2009-05-29  2334  		mutex_unlock(&ioc->taskmgmt_cmds.mutex);
ea2a788de4ce5e Kashyap, Desai  2009-05-29  2335  
^1da177e4c3f41 Linus Torvalds  2005-04-16  2336  
^1da177e4c3f41 Linus Torvalds  2005-04-16  2337  	mf = NULL;
^1da177e4c3f41 Linus Torvalds  2005-04-16  2338  
^1da177e4c3f41 Linus Torvalds  2005-04-16  2339  	/* If a valid reply frame, copy to the user.
^1da177e4c3f41 Linus Torvalds  2005-04-16  2340  	 * Offset 2: reply length in U32's
^1da177e4c3f41 Linus Torvalds  2005-04-16  2341  	 */
ea2a788de4ce5e Kashyap, Desai  2009-05-29  2342  	if (ioc->ioctl_cmds.status & MPT_MGMT_STATUS_RF_VALID) {
^1da177e4c3f41 Linus Torvalds  2005-04-16  2343  		if (karg.maxReplyBytes < ioc->reply_sz) {
ea2a788de4ce5e Kashyap, Desai  2009-05-29  2344  			sz = min(karg.maxReplyBytes,
ea2a788de4ce5e Kashyap, Desai  2009-05-29  2345  				4*ioc->ioctl_cmds.reply[2]);
^1da177e4c3f41 Linus Torvalds  2005-04-16  2346  		} else {
ea2a788de4ce5e Kashyap, Desai  2009-05-29  2347  			 sz = min(ioc->reply_sz, 4*ioc->ioctl_cmds.reply[2]);
^1da177e4c3f41 Linus Torvalds  2005-04-16  2348  		}
^1da177e4c3f41 Linus Torvalds  2005-04-16  2349  		if (sz > 0) {
^1da177e4c3f41 Linus Torvalds  2005-04-16  2350  			if (copy_to_user(karg.replyFrameBufPtr,
ea2a788de4ce5e Kashyap, Desai  2009-05-29  2351  				 ioc->ioctl_cmds.reply, sz)){
29dd3609f2fc70 Eric Moore      2007-09-14  2352  				 printk(MYIOC_s_ERR_FMT
^1da177e4c3f41 Linus Torvalds  2005-04-16  2353  				     "%s@%d::mptctl_do_mpt_command - "
^1da177e4c3f41 Linus Torvalds  2005-04-16  2354  				 "Unable to write out reply frame %p\n",
29dd3609f2fc70 Eric Moore      2007-09-14  2355  				 ioc->name, __FILE__, __LINE__, karg.replyFrameBufPtr);
^1da177e4c3f41 Linus Torvalds  2005-04-16  2356  				 rc =  -ENODATA;
^1da177e4c3f41 Linus Torvalds  2005-04-16  2357  				 goto done_free_mem;
^1da177e4c3f41 Linus Torvalds  2005-04-16  2358  			}
^1da177e4c3f41 Linus Torvalds  2005-04-16  2359  		}
^1da177e4c3f41 Linus Torvalds  2005-04-16  2360  	}
^1da177e4c3f41 Linus Torvalds  2005-04-16  2361  
^1da177e4c3f41 Linus Torvalds  2005-04-16  2362  	/* If valid sense data, copy to user.
^1da177e4c3f41 Linus Torvalds  2005-04-16  2363  	 */
ea2a788de4ce5e Kashyap, Desai  2009-05-29  2364  	if (ioc->ioctl_cmds.status & MPT_MGMT_STATUS_SENSE_VALID) {
^1da177e4c3f41 Linus Torvalds  2005-04-16  2365  		sz = min(karg.maxSenseBytes, MPT_SENSE_BUFFER_SIZE);
^1da177e4c3f41 Linus Torvalds  2005-04-16  2366  		if (sz > 0) {
ea2a788de4ce5e Kashyap, Desai  2009-05-29  2367  			if (copy_to_user(karg.senseDataPtr,
ea2a788de4ce5e Kashyap, Desai  2009-05-29  2368  				ioc->ioctl_cmds.sense, sz)) {
29dd3609f2fc70 Eric Moore      2007-09-14  2369  				printk(MYIOC_s_ERR_FMT "%s@%d::mptctl_do_mpt_command - "
^1da177e4c3f41 Linus Torvalds  2005-04-16  2370  				"Unable to write sense data to user %p\n",
29dd3609f2fc70 Eric Moore      2007-09-14  2371  				ioc->name, __FILE__, __LINE__,
^1da177e4c3f41 Linus Torvalds  2005-04-16  2372  				karg.senseDataPtr);
^1da177e4c3f41 Linus Torvalds  2005-04-16  2373  				rc =  -ENODATA;
^1da177e4c3f41 Linus Torvalds  2005-04-16  2374  				goto done_free_mem;
^1da177e4c3f41 Linus Torvalds  2005-04-16  2375  			}
^1da177e4c3f41 Linus Torvalds  2005-04-16  2376  		}
^1da177e4c3f41 Linus Torvalds  2005-04-16  2377  	}
^1da177e4c3f41 Linus Torvalds  2005-04-16  2378  
^1da177e4c3f41 Linus Torvalds  2005-04-16  2379  	/* If the overall status is _GOOD and data in, copy data
^1da177e4c3f41 Linus Torvalds  2005-04-16  2380  	 * to user.
^1da177e4c3f41 Linus Torvalds  2005-04-16  2381  	 */
ea2a788de4ce5e Kashyap, Desai  2009-05-29  2382  	if ((ioc->ioctl_cmds.status & MPT_MGMT_STATUS_COMMAND_GOOD) &&
^1da177e4c3f41 Linus Torvalds  2005-04-16  2383  				(karg.dataInSize > 0) && (bufIn.kptr)) {
^1da177e4c3f41 Linus Torvalds  2005-04-16  2384  
^1da177e4c3f41 Linus Torvalds  2005-04-16  2385  		if (copy_to_user(karg.dataInBufPtr,
^1da177e4c3f41 Linus Torvalds  2005-04-16  2386  				 bufIn.kptr, karg.dataInSize)) {
29dd3609f2fc70 Eric Moore      2007-09-14  2387  			printk(MYIOC_s_ERR_FMT "%s@%d::mptctl_do_mpt_command - "
^1da177e4c3f41 Linus Torvalds  2005-04-16  2388  				"Unable to write data to user %p\n",
29dd3609f2fc70 Eric Moore      2007-09-14  2389  				ioc->name, __FILE__, __LINE__,
^1da177e4c3f41 Linus Torvalds  2005-04-16  2390  				karg.dataInBufPtr);
^1da177e4c3f41 Linus Torvalds  2005-04-16  2391  			rc =  -ENODATA;
^1da177e4c3f41 Linus Torvalds  2005-04-16  2392  		}
^1da177e4c3f41 Linus Torvalds  2005-04-16  2393  	}
^1da177e4c3f41 Linus Torvalds  2005-04-16  2394  
^1da177e4c3f41 Linus Torvalds  2005-04-16  2395  done_free_mem:
^1da177e4c3f41 Linus Torvalds  2005-04-16  2396  
ea2a788de4ce5e Kashyap, Desai  2009-05-29  2397  	CLEAR_MGMT_STATUS(ioc->ioctl_cmds.status)
ea2a788de4ce5e Kashyap, Desai  2009-05-29  2398  	SET_MGMT_MSG_CONTEXT(ioc->ioctl_cmds.msg_context, 0);
^1da177e4c3f41 Linus Torvalds  2005-04-16  2399  
^1da177e4c3f41 Linus Torvalds  2005-04-16  2400  	/* Free the allocated memory.
^1da177e4c3f41 Linus Torvalds  2005-04-16  2401  	 */
^1da177e4c3f41 Linus Torvalds  2005-04-16  2402  	if (bufOut.kptr != NULL) {
^1da177e4c3f41 Linus Torvalds  2005-04-16  2403  		pci_free_consistent(ioc->pcidev,
^1da177e4c3f41 Linus Torvalds  2005-04-16  2404  			bufOut.len, (void *) bufOut.kptr, dma_addr_out);
^1da177e4c3f41 Linus Torvalds  2005-04-16  2405  	}
^1da177e4c3f41 Linus Torvalds  2005-04-16  2406  
^1da177e4c3f41 Linus Torvalds  2005-04-16  2407  	if (bufIn.kptr != NULL) {
^1da177e4c3f41 Linus Torvalds  2005-04-16  2408  		pci_free_consistent(ioc->pcidev,
^1da177e4c3f41 Linus Torvalds  2005-04-16  2409  			bufIn.len, (void *) bufIn.kptr, dma_addr_in);
^1da177e4c3f41 Linus Torvalds  2005-04-16  2410  	}
^1da177e4c3f41 Linus Torvalds  2005-04-16  2411  
^1da177e4c3f41 Linus Torvalds  2005-04-16  2412  	/* mf is null if command issued successfully
25985edcedea63 Lucas De Marchi 2011-03-30  2413  	 * otherwise, failure occurred after mf acquired.
^1da177e4c3f41 Linus Torvalds  2005-04-16  2414  	 */
^1da177e4c3f41 Linus Torvalds  2005-04-16  2415  	if (mf)
^1da177e4c3f41 Linus Torvalds  2005-04-16  2416  		mpt_free_msg_frame(ioc, mf);
^1da177e4c3f41 Linus Torvalds  2005-04-16  2417  
^1da177e4c3f41 Linus Torvalds  2005-04-16  2418  	return rc;
^1da177e4c3f41 Linus Torvalds  2005-04-16  2419  }
^1da177e4c3f41 Linus Torvalds  2005-04-16  2420  

:::::: The code at line 2300 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--3r6mift7r7cv6cpv
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
A12XEKDHnAMA

--3r6mift7r7cv6cpv--
